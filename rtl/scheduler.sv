`default_nettype none
`timescale 1ns/1ps

// SCHEDULER
// Synopsys DC / ICC2 / Fusion Compiler compatible
// - No automatic variables; loop variable declared at module level
// - Named block replaced with module-level reg for any_busy
// - Standard Verilog-2001 for loops
module scheduler #(
    parameter THREADS_PER_BLOCK = 4
) (
    input  wire        clk,
    input  wire        reset,
    input  wire        start,

    input  wire        decoded_mem_read_enable,
    input  wire        decoded_mem_write_enable,
    input  wire        decoded_ret,

    input  wire [2:0]  fetcher_state,
    input  wire [1:0]  lsu_state [THREADS_PER_BLOCK-1:0],

    output reg  [7:0]  current_pc,
    input  wire [7:0]  next_pc   [THREADS_PER_BLOCK-1:0],

    output reg  [2:0]  core_state,
    output reg         done
);
    localparam IDLE    = 3'b000,
               FETCH   = 3'b001,
               DECODE  = 3'b010,
               REQUEST = 3'b011,
               WAIT    = 3'b100,
               EXECUTE = 3'b101,
               UPDATE  = 3'b110,
               DONE_ST = 3'b111;

    localparam FETCHED       = 3'b010;
    localparam LSU_REQUESTING = 2'b01,
               LSU_WAITING    = 2'b10;

    // Module-level variables (no automatic) — DC compatible
    integer      lsu_i;
    reg          any_busy;

    always @(posedge clk) begin
        if (reset) begin
            current_pc <= 8'b0;
            core_state <= IDLE;
            done       <= 1'b0;
        end else begin
            case (core_state)
                IDLE: begin
                    if (start)
                        core_state <= FETCH;
                end
                FETCH: begin
                    if (fetcher_state == FETCHED)
                        core_state <= DECODE;
                end
                DECODE: begin
                    core_state <= REQUEST;
                end
                REQUEST: begin
                    core_state <= WAIT;
                end
                WAIT: begin
                    // Check all LSUs — module-level reg, no automatic needed
                    any_busy = 1'b0;
                    for (lsu_i = 0; lsu_i < THREADS_PER_BLOCK; lsu_i = lsu_i + 1) begin
                        if (lsu_state[lsu_i] == LSU_REQUESTING ||
                            lsu_state[lsu_i] == LSU_WAITING)
                            any_busy = 1'b1;
                    end
                    if (!any_busy)
                        core_state <= EXECUTE;
                end
                EXECUTE: begin
                    core_state <= UPDATE;
                end
                UPDATE: begin
                    if (decoded_ret) begin
                        done       <= 1'b1;
                        core_state <= DONE_ST;
                    end else begin
                        current_pc <= next_pc[0]; // Thread 0 — no branch divergence
                        core_state <= FETCH;
                    end
                end
                DONE_ST: begin
                    // Hold until dispatcher resets core
                end
                default: core_state <= IDLE;
            endcase
        end
    end
endmodule
