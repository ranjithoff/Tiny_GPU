`default_nettype none
`timescale 1ns/1ns

// COMPUTE CORE
// > Processes one block of threads at a time (Image 1: Compute Core diagram)
// > Contains one shared Scheduler, Fetcher, and Decoder
// > Contains one ALU, LSU, Register File, and PC per thread (Image 1: per-thread row)
// > Image 5 trace: each thread has its own RS/RT/ALU Out/Registers state
// > Threads execute in SIMD lockstep controlled by the Scheduler
module core #(
    parameter DATA_MEM_ADDR_BITS    = 8,
    parameter DATA_MEM_DATA_BITS    = 8,
    parameter PROGRAM_MEM_ADDR_BITS = 8,
    parameter PROGRAM_MEM_DATA_BITS = 16,
    parameter THREADS_PER_BLOCK     = 4
) (
    input wire        clk,
    input wire        reset,

    // Kernel execution (from Dispatcher, Image 2)
    input wire        start,
    output wire       done,

    // Block metadata (from Dispatcher)
    input wire [7:0]  block_id,
    input wire [$clog2(THREADS_PER_BLOCK):0] thread_count,

    // Program Memory (via Program Memory Controller, Image 2)
    output reg        program_mem_read_valid,
    output reg [PROGRAM_MEM_ADDR_BITS-1:0] program_mem_read_address,
    input  wire       program_mem_read_ready,
    input  wire [PROGRAM_MEM_DATA_BITS-1:0] program_mem_read_data,

    // Data Memory (via Cache → Data Memory Controller, Image 2)
    output reg [THREADS_PER_BLOCK-1:0]             data_mem_read_valid,
    output reg [DATA_MEM_ADDR_BITS-1:0]            data_mem_read_address  [THREADS_PER_BLOCK-1:0],
    input  wire [THREADS_PER_BLOCK-1:0]            data_mem_read_ready,
    input  wire [DATA_MEM_DATA_BITS-1:0]           data_mem_read_data     [THREADS_PER_BLOCK-1:0],
    output reg [THREADS_PER_BLOCK-1:0]             data_mem_write_valid,
    output reg [DATA_MEM_ADDR_BITS-1:0]            data_mem_write_address [THREADS_PER_BLOCK-1:0],
    output reg [DATA_MEM_DATA_BITS-1:0]            data_mem_write_data    [THREADS_PER_BLOCK-1:0],
    input  wire [THREADS_PER_BLOCK-1:0]            data_mem_write_ready
);
    // ---- Shared pipeline state ----
    wire [2:0]  core_state;
    wire [2:0]  fetcher_state;
    wire [15:0] instruction;
    wire [7:0]  current_pc;

    // ---- Per-thread intermediate signals ----
    wire [7:0]  next_pc   [THREADS_PER_BLOCK-1:0];
    wire [7:0]  rs        [THREADS_PER_BLOCK-1:0];
    wire [7:0]  rt        [THREADS_PER_BLOCK-1:0];
    wire [7:0]  alu_out   [THREADS_PER_BLOCK-1:0];
    wire [1:0]  lsu_state [THREADS_PER_BLOCK-1:0];
    wire [7:0]  lsu_out   [THREADS_PER_BLOCK-1:0];

    // ---- Decoded instruction signals ----
    wire [3:0]  decoded_rd_address;
    wire [3:0]  decoded_rs_address;
    wire [3:0]  decoded_rt_address;
    wire [2:0]  decoded_nzp;
    wire [7:0]  decoded_immediate;

    // ---- Decoded control signals ----
    wire        decoded_reg_write_enable;
    wire        decoded_mem_read_enable;
    wire        decoded_mem_write_enable;
    wire        decoded_nzp_write_enable;
    wire [1:0]  decoded_reg_input_mux;
    wire [1:0]  decoded_alu_arithmetic_mux;
    wire        decoded_alu_output_mux;
    wire        decoded_pc_mux;
    wire        decoded_ret;

    // ---- Scheduler (Image 1: top-level control block) ----
    scheduler #(
        .THREADS_PER_BLOCK(THREADS_PER_BLOCK)
    ) scheduler_instance (
        .clk(clk),
        .reset(reset),
        .start(start),
        .fetcher_state(fetcher_state),
        .core_state(core_state),
        .decoded_mem_read_enable(decoded_mem_read_enable),
        .decoded_mem_write_enable(decoded_mem_write_enable),
        .decoded_ret(decoded_ret),
        .lsu_state(lsu_state),
        .current_pc(current_pc),
        .next_pc(next_pc),
        .done(done)
    );

    // ---- Fetcher (Image 1: second block) ----
    fetcher #(
        .PROGRAM_MEM_ADDR_BITS(PROGRAM_MEM_ADDR_BITS),
        .PROGRAM_MEM_DATA_BITS(PROGRAM_MEM_DATA_BITS)
    ) fetcher_instance (
        .clk(clk),
        .reset(reset),
        .core_state(core_state),
        .current_pc(current_pc),
        .mem_read_valid(program_mem_read_valid),
        .mem_read_address(program_mem_read_address),
        .mem_read_ready(program_mem_read_ready),
        .mem_read_data(program_mem_read_data),
        .fetcher_state(fetcher_state),
        .instruction(instruction)
    );

    // ---- Decoder (Image 1: third block; fans to all threads) ----
    decoder decoder_instance (
        .clk(clk),
        .reset(reset),
        .core_state(core_state),
        .instruction(instruction),
        .decoded_rd_address(decoded_rd_address),
        .decoded_rs_address(decoded_rs_address),
        .decoded_rt_address(decoded_rt_address),
        .decoded_nzp(decoded_nzp),
        .decoded_immediate(decoded_immediate),
        .decoded_reg_write_enable(decoded_reg_write_enable),
        .decoded_mem_read_enable(decoded_mem_read_enable),
        .decoded_mem_write_enable(decoded_mem_write_enable),
        .decoded_nzp_write_enable(decoded_nzp_write_enable),
        .decoded_reg_input_mux(decoded_reg_input_mux),
        .decoded_alu_arithmetic_mux(decoded_alu_arithmetic_mux),
        .decoded_alu_output_mux(decoded_alu_output_mux),
        .decoded_pc_mux(decoded_pc_mux),
        .decoded_ret(decoded_ret)
    );

    // ---- Per-thread units (Image 1: two rows of 4 thread columns) ----
    genvar i;
    generate
        for (i = 0; i < THREADS_PER_BLOCK; i = i + 1) begin : thread_units

            // ALU (Image 1: ALU per thread; Image 4: Arithmetic + Comparison paths)
            alu alu_inst (
                .clk(clk),
                .reset(reset),
                .enable(i < thread_count),
                .core_state(core_state),
                .decoded_alu_arithmetic_mux(decoded_alu_arithmetic_mux),
                .decoded_alu_output_mux(decoded_alu_output_mux),
                .rs(rs[i]),
                .rt(rt[i]),
                .alu_out(alu_out[i])
            );

            // LSU (Image 1: LSU per thread; Image 4: Load/Store paths)
            lsu lsu_inst (
                .clk(clk),
                .reset(reset),
                .enable(i < thread_count),
                .core_state(core_state),
                .decoded_mem_read_enable(decoded_mem_read_enable),
                .decoded_mem_write_enable(decoded_mem_write_enable),
                .rs(rs[i]),
                .rt(rt[i]),
                .mem_read_valid(data_mem_read_valid[i]),
                .mem_read_address(data_mem_read_address[i]),
                .mem_read_ready(data_mem_read_ready[i]),
                .mem_read_data(data_mem_read_data[i]),
                .mem_write_valid(data_mem_write_valid[i]),
                .mem_write_address(data_mem_write_address[i]),
                .mem_write_data(data_mem_write_data[i]),
                .mem_write_ready(data_mem_write_ready[i]),
                .lsu_state(lsu_state[i]),
                .lsu_out(lsu_out[i])
            );

            // Register File (Image 1: Registers per thread; Image 4: Register File)
            registers #(
                .THREADS_PER_BLOCK(THREADS_PER_BLOCK),
                .THREAD_ID(i),
                .DATA_BITS(DATA_MEM_DATA_BITS)
            ) registers_inst (
                .clk(clk),
                .reset(reset),
                .enable(i < thread_count),
                .block_id(block_id),
                .core_state(core_state),
                .decoded_reg_write_enable(decoded_reg_write_enable),
                .decoded_reg_input_mux(decoded_reg_input_mux),
                .decoded_rd_address(decoded_rd_address),
                .decoded_rs_address(decoded_rs_address),
                .decoded_rt_address(decoded_rt_address),
                .decoded_immediate(decoded_immediate),
                .alu_out(alu_out[i]),
                .lsu_out(lsu_out[i]),
                .rs(rs[i]),
                .rt(rt[i])
            );

            // Program Counter (Image 1: PC per thread; Image 4: PC + NZP block)
            pc #(
                .DATA_MEM_DATA_BITS(DATA_MEM_DATA_BITS),
                .PROGRAM_MEM_ADDR_BITS(PROGRAM_MEM_ADDR_BITS)
            ) pc_inst (
                .clk(clk),
                .reset(reset),
                .enable(i < thread_count),
                .core_state(core_state),
                .decoded_nzp(decoded_nzp),
                .decoded_immediate(decoded_immediate),
                .decoded_nzp_write_enable(decoded_nzp_write_enable),
                .decoded_pc_mux(decoded_pc_mux),
                .alu_out(alu_out[i]),
                .current_pc(current_pc),
                .next_pc(next_pc[i])
            );
        end
    endgenerate
endmodule
