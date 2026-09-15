`default_nettype none
`timescale 1ns/1ns

// BLOCK DISPATCHER
// > Top-level dispatch unit — one per GPU (Image 2: Dispatcher block)
// > Splits the total thread count into blocks of THREADS_PER_BLOCK
// > Assigns blocks to available compute cores and tracks completion
// > When all blocks are done, asserts the GPU-level done signal
// > Image 2 shows 4 compute cores; NUM_CORES defaults to 4 to match
module dispatch #(
    parameter NUM_CORES        = 4,
    parameter THREADS_PER_BLOCK = 4
) (
    input wire        clk,
    input wire        reset,
    input wire        start,

    // Kernel metadata — total threads loaded via DCR (Image 2)
    input wire [7:0]  thread_count,

    // Core control signals (Image 2: Dispatcher → Compute Cores)
    input  wire [NUM_CORES-1:0]                     core_done,
    output reg  [NUM_CORES-1:0]                     core_start,
    output reg  [NUM_CORES-1:0]                     core_reset,
    output reg  [7:0]                               core_block_id     [NUM_CORES-1:0],
    output reg  [$clog2(THREADS_PER_BLOCK):0]       core_thread_count [NUM_CORES-1:0],

    output reg        done
);
    // Total number of blocks = ceil(thread_count / THREADS_PER_BLOCK)
    wire [7:0] total_blocks;
    assign total_blocks = (thread_count + THREADS_PER_BLOCK - 1) / THREADS_PER_BLOCK;

    reg [7:0] blocks_dispatched;
    reg [7:0] blocks_done;
    reg       start_latch; // Captures rising edge of start (EDA-safe single-clock method)

    integer i;
    always @(posedge clk) begin
        if (reset) begin
            done              <= 1'b0;
            blocks_dispatched <= 8'b0;
            blocks_done       <= 8'b0;
            start_latch       <= 1'b0;
            for (i = 0; i < NUM_CORES; i = i + 1) begin
                core_start[i]        <= 1'b0;
                core_reset[i]        <= 1'b1;
                core_block_id[i]     <= 8'b0;
                core_thread_count[i] <= THREADS_PER_BLOCK[$clog2(THREADS_PER_BLOCK):0];
            end
        end else if (start) begin

            // On first cycle of start, latch and trigger core resets
            if (!start_latch) begin
                start_latch <= 1'b1;
                for (i = 0; i < NUM_CORES; i = i + 1)
                    core_reset[i] <= 1'b1;
            end

            // All blocks done → assert kernel done
            if (blocks_done == total_blocks)
                done <= 1'b1;

            // After reset deasserts, dispatch next available block to that core
            for (i = 0; i < NUM_CORES; i = i + 1) begin
                if (core_reset[i]) begin
                    core_reset[i] <= 1'b0;

                    if (blocks_dispatched < total_blocks) begin
                        core_start[i]    <= 1'b1;
                        core_block_id[i] <= blocks_dispatched;

                        // Last block may have fewer than THREADS_PER_BLOCK threads
                        if (blocks_dispatched == total_blocks - 8'd1)
                            core_thread_count[i] <=
                                thread_count - (blocks_dispatched * THREADS_PER_BLOCK);
                        else
                            core_thread_count[i] <= THREADS_PER_BLOCK[$clog2(THREADS_PER_BLOCK):0];

                        blocks_dispatched <= blocks_dispatched + 8'd1;
                    end
                end
            end

            // Detect core completion and reset it for next block
            for (i = 0; i < NUM_CORES; i = i + 1) begin
                if (core_start[i] && core_done[i]) begin
                    core_reset[i] <= 1'b1;
                    core_start[i] <= 1'b0;
                    blocks_done   <= blocks_done + 8'd1;
                end
            end
        end
    end
endmodule
