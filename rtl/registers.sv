`default_nettype none
`timescale 1ns/1ns

// REGISTER FILE
// > Each thread has its own register file (Image 1: Registers block per thread)
// > 16 registers total: R0–R12 (general purpose) + 3 read-only SIMD registers
//     R13 = %blockIdx  (set by dispatcher)
//     R14 = %blockDim  (constant = THREADS_PER_BLOCK)
//     R15 = %threadIdx (constant = THREAD_ID)
// > Image 4: rs_address / rt_address → rs / rt outputs to ALU & LSU
//            reg_input_mux selects write source: ALU, LSU, or IMM
//            rd written during UPDATE state; rs/rt read during REQUEST state
// > Image 5 trace shows %blockDim=4, %threadIdx=0..3 correctly at reset
module registers #(
    parameter THREADS_PER_BLOCK = 4,
    parameter THREAD_ID         = 0,
    parameter DATA_BITS         = 8
) (
    input wire        clk,
    input wire        reset,
    input wire        enable,

    input wire [7:0]  block_id,          // From Dispatcher (Image 2)
    input wire [2:0]  core_state,

    // Decoded instruction fields (Image 4)
    input wire [3:0]  decoded_rd_address,
    input wire [3:0]  decoded_rs_address,
    input wire [3:0]  decoded_rt_address,

    // Control signals (Image 4)
    input wire        decoded_reg_write_enable,
    input wire [1:0]  decoded_reg_input_mux, // 00=ALU 01=LSU 10=IMM
    input wire [DATA_BITS-1:0] decoded_immediate,

    // Data inputs (Image 4: three mux inputs)
    input wire [DATA_BITS-1:0] alu_out,
    input wire [DATA_BITS-1:0] lsu_out,

    // Register read outputs → ALU and LSU (Image 4)
    output reg [7:0] rs,
    output reg [7:0] rt
);
    localparam ARITHMETIC = 2'b00,
               MEMORY     = 2'b01,
               CONSTANT   = 2'b10;

    localparam REQUEST = 3'b011,
               UPDATE  = 3'b110;

    reg [7:0] regs [15:0]; // 16 registers

    integer k;
    always @(posedge clk) begin
        if (reset) begin
            rs <= 8'b0;
            rt <= 8'b0;
            for (k = 0; k < 13; k = k + 1)
                regs[k] <= 8'b0;
            // Read-only SIMD registers (Image 5 trace values)
            regs[13] <= 8'b0;                          // %blockIdx  (updated each block)
            regs[14] <= THREADS_PER_BLOCK[7:0];        // %blockDim
            regs[15] <= THREAD_ID[7:0];                // %threadIdx
        end else if (enable) begin
            // Update %blockIdx every cycle (set by dispatcher per block)
            regs[13] <= block_id;

            // REQUEST state: read rs and rt from register file (Image 4)
            if (core_state == REQUEST) begin
                rs <= regs[decoded_rs_address];
                rt <= regs[decoded_rt_address];
            end

            // UPDATE state: write rd (only R0–R12 are writable)
            if (core_state == UPDATE) begin
                if (decoded_reg_write_enable && (decoded_rd_address <= 4'd12)) begin
                    case (decoded_reg_input_mux)
                        ARITHMETIC: regs[decoded_rd_address] <= alu_out;      // ADD/SUB/MUL/DIV
                        MEMORY:     regs[decoded_rd_address] <= lsu_out;      // LDR
                        CONSTANT:   regs[decoded_rd_address] <= decoded_immediate; // CONST
                        default:    regs[decoded_rd_address] <= alu_out;
                    endcase
                end
            end
        end
    end
endmodule
