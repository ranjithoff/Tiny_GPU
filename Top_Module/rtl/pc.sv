`default_nettype none
`timescale 1ns/1ns

// PROGRAM COUNTER
// > Calculates next_pc for each thread (Image 4: PC block on right side)
// > Image 4 datapath:
//     NZP Register ← alu_out[2:0]  (written on CMP via nzp_write_enable)
//     NZP Tester   compares nzp & decoded_nzp → branch signal
//     pc_mux:  0 → current_pc + 1
//              1 → branch target (immediate) if NZP matches, else current_pc + 1
// > NZP register updated during UPDATE state
// > next_pc calculated during EXECUTE state
// > No branch divergence support (all threads share same PC — scheduler picks [0])
module pc #(
    parameter DATA_MEM_DATA_BITS   = 8,
    parameter PROGRAM_MEM_ADDR_BITS = 8
) (
    input wire        clk,
    input wire        reset,
    input wire        enable,                           // Inactive when thread slot unused

    input wire [2:0]  core_state,

    // Control signals from Decoder (Image 4)
    input wire [2:0]  decoded_nzp,                     // NZP condition mask for BRnzp
    input wire [DATA_MEM_DATA_BITS-1:0] decoded_immediate, // Branch target (IMM8)
    input wire        decoded_nzp_write_enable,         // Write NZP on CMP
    input wire        decoded_pc_mux,                   // 0=PC+1  1=branch

    // ALU output — alu_out[2:0] are N/Z/P flags from CMP (Image 4)
    input wire [DATA_MEM_DATA_BITS-1:0] alu_out,

    input wire  [PROGRAM_MEM_ADDR_BITS-1:0] current_pc,
    output reg  [PROGRAM_MEM_ADDR_BITS-1:0] next_pc
);
    localparam EXECUTE = 3'b101,
               UPDATE  = 3'b110;

    reg [2:0] nzp_reg; // NZP register (Image 4: NZP Register block)

    always @(posedge clk) begin
        if (reset) begin
            nzp_reg <= 3'b0;
            next_pc <= {PROGRAM_MEM_ADDR_BITS{1'b0}};
        end else if (enable) begin

            // ---- EXECUTE: compute next_pc (Image 4: NZP Tester + pc_mux) ----
            if (core_state == EXECUTE) begin
                if (decoded_pc_mux) begin
                    // BRnzp: branch if any matching NZP bit set
                    if ((nzp_reg & decoded_nzp) != 3'b0)
                        next_pc <= decoded_immediate[PROGRAM_MEM_ADDR_BITS-1:0];
                    else
                        next_pc <= current_pc + 1'b1;
                end else begin
                    next_pc <= current_pc + 1'b1;
                end
            end

            // ---- UPDATE: latch NZP flags from ALU (Image 4: NZP Register) ----
            if (core_state == UPDATE) begin
                if (decoded_nzp_write_enable) begin
                    nzp_reg[2] <= alu_out[2]; // N
                    nzp_reg[1] <= alu_out[1]; // Z
                    nzp_reg[0] <= alu_out[0]; // P
                end
            end
        end
    end
endmodule
