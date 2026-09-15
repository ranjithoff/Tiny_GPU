`default_nettype none
`timescale 1ns/1ps

// GPU TOP-LEVEL
// Synopsys DC / ICC2 / Fusion Compiler compatible
// Fix: Replaced '{default:...} assignment patterns (VER-721) with explicit
//      tied-off wire arrays for read-only program memory controller write ports
module gpu #(
    parameter DATA_MEM_ADDR_BITS       = 8,
    parameter DATA_MEM_DATA_BITS       = 8,
    parameter DATA_MEM_NUM_CHANNELS    = 4,
    parameter PROGRAM_MEM_ADDR_BITS    = 8,
    parameter PROGRAM_MEM_DATA_BITS    = 16,
    parameter PROGRAM_MEM_NUM_CHANNELS = 1,
    parameter NUM_CORES                = 4,
    parameter THREADS_PER_BLOCK        = 4,
    parameter CACHE_SIZE               = 16
) (
    input  wire clk,
    input  wire reset,
    input  wire start,
    output wire done,

    input  wire        device_control_write_enable,
    input  wire [7:0]  device_control_data,

    // Program Memory
    output wire [PROGRAM_MEM_NUM_CHANNELS-1:0]           program_mem_read_valid,
    output wire [PROGRAM_MEM_ADDR_BITS-1:0]              program_mem_read_address [PROGRAM_MEM_NUM_CHANNELS-1:0],
    input  wire [PROGRAM_MEM_NUM_CHANNELS-1:0]           program_mem_read_ready,
    input  wire [PROGRAM_MEM_DATA_BITS-1:0]              program_mem_read_data    [PROGRAM_MEM_NUM_CHANNELS-1:0],

    // Data Memory
    output wire [DATA_MEM_NUM_CHANNELS-1:0]              data_mem_read_valid,
    output wire [DATA_MEM_ADDR_BITS-1:0]                 data_mem_read_address    [DATA_MEM_NUM_CHANNELS-1:0],
    input  wire [DATA_MEM_NUM_CHANNELS-1:0]              data_mem_read_ready,
    input  wire [DATA_MEM_DATA_BITS-1:0]                 data_mem_read_data       [DATA_MEM_NUM_CHANNELS-1:0],
    output wire [DATA_MEM_NUM_CHANNELS-1:0]              data_mem_write_valid,
    output wire [DATA_MEM_ADDR_BITS-1:0]                 data_mem_write_address   [DATA_MEM_NUM_CHANNELS-1:0],
    output wire [DATA_MEM_DATA_BITS-1:0]                 data_mem_write_data      [DATA_MEM_NUM_CHANNELS-1:0],
    input  wire [DATA_MEM_NUM_CHANNELS-1:0]              data_mem_write_ready
);
    // -------------------------------------------------------------------------
    // Localparams
    // -------------------------------------------------------------------------
    localparam NUM_LSUS       = NUM_CORES * THREADS_PER_BLOCK;
    localparam NUM_FETCHERS   = NUM_CORES;
    localparam CACHE_IDX_BITS = $clog2(CACHE_SIZE);

    // -------------------------------------------------------------------------
    // Control signals
    // -------------------------------------------------------------------------
    wire [7:0] thread_count;

    reg [NUM_CORES-1:0]                core_start;
    reg [NUM_CORES-1:0]                core_reset;
    reg [NUM_CORES-1:0]                core_done;
    reg [7:0]                          core_block_id     [NUM_CORES-1:0];
    reg [$clog2(THREADS_PER_BLOCK):0]  core_thread_count [NUM_CORES-1:0];

    // -------------------------------------------------------------------------
    // LSU <-> Cache buses
    // -------------------------------------------------------------------------
    reg [NUM_LSUS-1:0]             lsu_read_valid;
    reg [DATA_MEM_ADDR_BITS-1:0]   lsu_read_address  [NUM_LSUS-1:0];
    reg [NUM_LSUS-1:0]             lsu_read_ready;
    reg [DATA_MEM_DATA_BITS-1:0]   lsu_read_data     [NUM_LSUS-1:0];
    reg [NUM_LSUS-1:0]             lsu_write_valid;
    reg [DATA_MEM_ADDR_BITS-1:0]   lsu_write_address [NUM_LSUS-1:0];
    reg [DATA_MEM_DATA_BITS-1:0]   lsu_write_data    [NUM_LSUS-1:0];
    reg [NUM_LSUS-1:0]             lsu_write_ready;

    // Cache <-> Data Memory Controller buses
    reg [NUM_LSUS-1:0]             cache_mem_read_valid;
    reg [DATA_MEM_ADDR_BITS-1:0]   cache_mem_read_address  [NUM_LSUS-1:0];
    reg [NUM_LSUS-1:0]             cache_mem_read_ready;
    reg [DATA_MEM_DATA_BITS-1:0]   cache_mem_read_data     [NUM_LSUS-1:0];
    reg [NUM_LSUS-1:0]             cache_mem_write_valid;
    reg [DATA_MEM_ADDR_BITS-1:0]   cache_mem_write_address [NUM_LSUS-1:0];
    reg [DATA_MEM_DATA_BITS-1:0]   cache_mem_write_data    [NUM_LSUS-1:0];
    reg [NUM_LSUS-1:0]             cache_mem_write_ready;

    // -------------------------------------------------------------------------
    // Fetcher <-> Program Memory Controller buses
    // -------------------------------------------------------------------------
    reg [NUM_FETCHERS-1:0]              fetcher_read_valid;
    reg [PROGRAM_MEM_ADDR_BITS-1:0]     fetcher_read_address [NUM_FETCHERS-1:0];
    reg [NUM_FETCHERS-1:0]              fetcher_read_ready;
    reg [PROGRAM_MEM_DATA_BITS-1:0]     fetcher_read_data    [NUM_FETCHERS-1:0];

    // -------------------------------------------------------------------------
    // Tied-off write ports for read-only program memory controller
    // DC Presto does NOT support '{default:...} patterns in port connections
    // (VER-721). Use explicit wire arrays assigned to zero instead.
    // -------------------------------------------------------------------------
    wire [NUM_FETCHERS-1:0]              pgm_wr_valid_tie = {NUM_FETCHERS{1'b0}};
    wire [PROGRAM_MEM_ADDR_BITS-1:0]     pgm_wr_addr_tie  [NUM_FETCHERS-1:0];
    wire [PROGRAM_MEM_DATA_BITS-1:0]     pgm_wr_data_tie  [NUM_FETCHERS-1:0];
    wire [NUM_FETCHERS-1:0]              pgm_wr_ready_nc;      // not connected (output)
    wire [PROGRAM_MEM_NUM_CHANNELS-1:0]  pgm_mem_wr_valid_nc;
    wire [PROGRAM_MEM_ADDR_BITS-1:0]     pgm_mem_wr_addr_nc   [PROGRAM_MEM_NUM_CHANNELS-1:0];
    wire [PROGRAM_MEM_DATA_BITS-1:0]     pgm_mem_wr_data_nc   [PROGRAM_MEM_NUM_CHANNELS-1:0];
    wire [PROGRAM_MEM_NUM_CHANNELS-1:0]  pgm_mem_wr_ready_tie = {PROGRAM_MEM_NUM_CHANNELS{1'b0}};

    genvar tie_i;
    generate
        for (tie_i = 0; tie_i < NUM_FETCHERS; tie_i = tie_i + 1) begin : pgm_tie
            assign pgm_wr_addr_tie[tie_i] = {PROGRAM_MEM_ADDR_BITS{1'b0}};
            assign pgm_wr_data_tie[tie_i] = {PROGRAM_MEM_DATA_BITS{1'b0}};
        end
    endgenerate

    // -------------------------------------------------------------------------
    // Shared Cache — direct-mapped, write-through
    // -------------------------------------------------------------------------
    reg [DATA_MEM_DATA_BITS-1:0]  cache_data  [CACHE_SIZE-1:0];
    reg [DATA_MEM_ADDR_BITS-1:0]  cache_tag   [CACHE_SIZE-1:0];
    reg                           cache_valid [CACHE_SIZE-1:0];

    // Module-level loop variables and temporaries (no automatic — DC compatible)
    integer ci, ri;
    reg [CACHE_IDX_BITS-1:0] c_ridx;
    reg [CACHE_IDX_BITS-1:0] c_widx;

    always @(posedge clk) begin
        if (reset) begin
            cache_mem_read_valid  <= {NUM_LSUS{1'b0}};
            cache_mem_write_valid <= {NUM_LSUS{1'b0}};
            lsu_read_ready        <= {NUM_LSUS{1'b0}};
            lsu_write_ready       <= {NUM_LSUS{1'b0}};
            for (ri = 0; ri < CACHE_SIZE; ri = ri + 1) begin
                cache_valid[ri] <= 1'b0;
                cache_tag[ri]   <= {DATA_MEM_ADDR_BITS{1'b0}};
                cache_data[ri]  <= {DATA_MEM_DATA_BITS{1'b0}};
            end
        end else begin
            for (ci = 0; ci < NUM_LSUS; ci = ci + 1) begin
                c_ridx = lsu_read_address[ci][CACHE_IDX_BITS-1:0];
                c_widx = lsu_write_address[ci][CACHE_IDX_BITS-1:0];

                // READ path
                if (lsu_read_valid[ci]) begin
                    if (cache_valid[c_ridx] && cache_tag[c_ridx] == lsu_read_address[ci]) begin
                        // HIT
                        lsu_read_data[ci]        <= cache_data[c_ridx];
                        lsu_read_ready[ci]       <= 1'b1;
                        cache_mem_read_valid[ci] <= 1'b0;
                    end else begin
                        // MISS
                        cache_mem_read_valid[ci]   <= 1'b1;
                        cache_mem_read_address[ci] <= lsu_read_address[ci];
                        lsu_read_ready[ci]         <= 1'b0;
                        if (cache_mem_read_ready[ci]) begin
                            cache_valid[c_ridx]      <= 1'b1;
                            cache_tag[c_ridx]        <= lsu_read_address[ci];
                            cache_data[c_ridx]       <= cache_mem_read_data[ci];
                            lsu_read_data[ci]        <= cache_mem_read_data[ci];
                            lsu_read_ready[ci]       <= 1'b1;
                            cache_mem_read_valid[ci] <= 1'b0;
                        end
                    end
                end else begin
                    lsu_read_ready[ci]       <= 1'b0;
                    cache_mem_read_valid[ci] <= 1'b0;
                end

                // WRITE path (write-through)
                if (lsu_write_valid[ci]) begin
                    if (cache_valid[c_widx] && cache_tag[c_widx] == lsu_write_address[ci])
                        cache_data[c_widx] <= lsu_write_data[ci];
                    cache_mem_write_valid[ci]   <= 1'b1;
                    cache_mem_write_address[ci] <= lsu_write_address[ci];
                    cache_mem_write_data[ci]    <= lsu_write_data[ci];
                    if (cache_mem_write_ready[ci]) begin
                        lsu_write_ready[ci]       <= 1'b1;
                        cache_mem_write_valid[ci] <= 1'b0;
                    end else begin
                        lsu_write_ready[ci] <= 1'b0;
                    end
                end else begin
                    lsu_write_ready[ci]       <= 1'b0;
                    cache_mem_write_valid[ci] <= 1'b0;
                end
            end
        end
    end

    // -------------------------------------------------------------------------
    // Device Control Register
    // -------------------------------------------------------------------------
    dcr dcr_instance (
        .clk(clk),
        .reset(reset),
        .device_control_write_enable(device_control_write_enable),
        .device_control_data(device_control_data),
        .thread_count(thread_count)
    );

    // -------------------------------------------------------------------------
    // Dispatcher
    // -------------------------------------------------------------------------
    dispatch #(
        .NUM_CORES(NUM_CORES),
        .THREADS_PER_BLOCK(THREADS_PER_BLOCK)
    ) dispatch_instance (
        .clk(clk),
        .reset(reset),
        .start(start),
        .thread_count(thread_count),
        .core_done(core_done),
        .core_start(core_start),
        .core_reset(core_reset),
        .core_block_id(core_block_id),
        .core_thread_count(core_thread_count),
        .done(done)
    );

    // -------------------------------------------------------------------------
    // Data Memory Controller
    // -------------------------------------------------------------------------
    controller #(
        .ADDR_BITS(DATA_MEM_ADDR_BITS),
        .DATA_BITS(DATA_MEM_DATA_BITS),
        .NUM_CONSUMERS(NUM_LSUS),
        .NUM_CHANNELS(DATA_MEM_NUM_CHANNELS),
        .WRITE_ENABLE(1)
    ) data_memory_controller (
        .clk(clk),
        .reset(reset),
        .consumer_read_valid(cache_mem_read_valid),
        .consumer_read_address(cache_mem_read_address),
        .consumer_read_ready(cache_mem_read_ready),
        .consumer_read_data(cache_mem_read_data),
        .consumer_write_valid(cache_mem_write_valid),
        .consumer_write_address(cache_mem_write_address),
        .consumer_write_data(cache_mem_write_data),
        .consumer_write_ready(cache_mem_write_ready),
        .mem_read_valid(data_mem_read_valid),
        .mem_read_address(data_mem_read_address),
        .mem_read_ready(data_mem_read_ready),
        .mem_read_data(data_mem_read_data),
        .mem_write_valid(data_mem_write_valid),
        .mem_write_address(data_mem_write_address),
        .mem_write_data(data_mem_write_data),
        .mem_write_ready(data_mem_write_ready)
    );

    // -------------------------------------------------------------------------
    // Program Memory Controller (WRITE_ENABLE=0, read-only)
    // Write ports tied to zero via explicit wire arrays (no '{default:...})
    // -------------------------------------------------------------------------
    controller #(
        .ADDR_BITS(PROGRAM_MEM_ADDR_BITS),
        .DATA_BITS(PROGRAM_MEM_DATA_BITS),
        .NUM_CONSUMERS(NUM_FETCHERS),
        .NUM_CHANNELS(PROGRAM_MEM_NUM_CHANNELS),
        .WRITE_ENABLE(0)
    ) program_memory_controller (
        .clk(clk),
        .reset(reset),
        .consumer_read_valid(fetcher_read_valid),
        .consumer_read_address(fetcher_read_address),
        .consumer_read_ready(fetcher_read_ready),
        .consumer_read_data(fetcher_read_data),
        .consumer_write_valid(pgm_wr_valid_tie),
        .consumer_write_address(pgm_wr_addr_tie),
        .consumer_write_data(pgm_wr_data_tie),
        .consumer_write_ready(pgm_wr_ready_nc),
        .mem_read_valid(program_mem_read_valid),
        .mem_read_address(program_mem_read_address),
        .mem_read_ready(program_mem_read_ready),
        .mem_read_data(program_mem_read_data),
        .mem_write_valid(pgm_mem_wr_valid_nc),
        .mem_write_address(pgm_mem_wr_addr_nc),
        .mem_write_data(pgm_mem_wr_data_nc),
        .mem_write_ready(pgm_mem_wr_ready_tie)
    );

    // -------------------------------------------------------------------------
    // Compute Cores
    // -------------------------------------------------------------------------
    genvar i, j;
    generate
        for (i = 0; i < NUM_CORES; i = i + 1) begin : cores
            reg [THREADS_PER_BLOCK-1:0]      core_lsu_read_valid;
            reg [DATA_MEM_ADDR_BITS-1:0]     core_lsu_read_address  [THREADS_PER_BLOCK-1:0];
            reg [THREADS_PER_BLOCK-1:0]      core_lsu_read_ready;
            reg [DATA_MEM_DATA_BITS-1:0]     core_lsu_read_data     [THREADS_PER_BLOCK-1:0];
            reg [THREADS_PER_BLOCK-1:0]      core_lsu_write_valid;
            reg [DATA_MEM_ADDR_BITS-1:0]     core_lsu_write_address [THREADS_PER_BLOCK-1:0];
            reg [DATA_MEM_DATA_BITS-1:0]     core_lsu_write_data    [THREADS_PER_BLOCK-1:0];
            reg [THREADS_PER_BLOCK-1:0]      core_lsu_write_ready;

            for (j = 0; j < THREADS_PER_BLOCK; j = j + 1) begin : lsu_bridge
                localparam integer LSU_IDX = i * THREADS_PER_BLOCK + j;
                always @(posedge clk) begin
                    lsu_read_valid[LSU_IDX]    <= core_lsu_read_valid[j];
                    lsu_read_address[LSU_IDX]  <= core_lsu_read_address[j];
                    lsu_write_valid[LSU_IDX]   <= core_lsu_write_valid[j];
                    lsu_write_address[LSU_IDX] <= core_lsu_write_address[j];
                    lsu_write_data[LSU_IDX]    <= core_lsu_write_data[j];
                    core_lsu_read_ready[j]     <= lsu_read_ready[LSU_IDX];
                    core_lsu_read_data[j]      <= lsu_read_data[LSU_IDX];
                    core_lsu_write_ready[j]    <= lsu_write_ready[LSU_IDX];
                end
            end

            core #(
                .DATA_MEM_ADDR_BITS(DATA_MEM_ADDR_BITS),
                .DATA_MEM_DATA_BITS(DATA_MEM_DATA_BITS),
                .PROGRAM_MEM_ADDR_BITS(PROGRAM_MEM_ADDR_BITS),
                .PROGRAM_MEM_DATA_BITS(PROGRAM_MEM_DATA_BITS),
                .THREADS_PER_BLOCK(THREADS_PER_BLOCK)
            ) core_instance (
                .clk(clk),
                .reset(core_reset[i]),
                .start(core_start[i]),
                .done(core_done[i]),
                .block_id(core_block_id[i]),
                .thread_count(core_thread_count[i]),
                .program_mem_read_valid(fetcher_read_valid[i]),
                .program_mem_read_address(fetcher_read_address[i]),
                .program_mem_read_ready(fetcher_read_ready[i]),
                .program_mem_read_data(fetcher_read_data[i]),
                .data_mem_read_valid(core_lsu_read_valid),
                .data_mem_read_address(core_lsu_read_address),
                .data_mem_read_ready(core_lsu_read_ready),
                .data_mem_read_data(core_lsu_read_data),
                .data_mem_write_valid(core_lsu_write_valid),
                .data_mem_write_address(core_lsu_write_address),
                .data_mem_write_data(core_lsu_write_data),
                .data_mem_write_ready(core_lsu_write_ready)
            );
        end
    endgenerate
endmodule
