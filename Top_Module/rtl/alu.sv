`default_nettype none
`timescale 1ns/1ps

// ARITHMETIC-LOGIC UNIT
// Synopsys DC / ICC2 / Fusion Compiler compatible
// - No automatic variables
// - No $signed inline cast in expressions (use signed wire declarations)
// - Standard Verilog-2001 style throughout
module alu (
    input  wire        clk,
    input  wire        reset,
    input  wire        enable,

    input  wire [2:0]  core_state,
    input  wire [1:0]  decoded_alu_arithmetic_mux,
    input  wire        decoded_alu_output_mux,

    input  wire [7:0]  rs,
    input  wire [7:0]  rt,
    output wire [7:0]  alu_out
);
    localparam EXECUTE = 3'b101;
    localparam ADD = 2'b00, SUB = 2'b01, MUL = 2'b10, DIV = 2'b11;

    reg [7:0] alu_out_reg;
    assign alu_out = alu_out_reg;

    // Signed wires — DC-safe way to do signed arithmetic
    wire signed [7:0] rs_s;
    wire signed [7:0] rt_s;
    wire signed [8:0] diff_s; // 9-bit to avoid overflow masking sign

    assign rs_s   = rs;
    assign rt_s   = rt;
    assign diff_s = {rs_s[7], rs_s} - {rt_s[7], rt_s}; // sign-extended subtract

    always @(posedge clk) begin
        if (reset) begin
            alu_out_reg <= 8'b0;
        end else if (enable) begin
            if (core_state == EXECUTE) begin
                if (decoded_alu_output_mux) begin
                    // CMP: N=bit2 Z=bit1 P=bit0
                    alu_out_reg <= {5'b0,
                                    (~diff_s[8] & |diff_s[7:0]),  // N: positive diff means rs>rt
                                    (diff_s == 9'b0),              // Z
                                    (diff_s[8])};                  // P: negative diff means rs<rt
                end else begin
                    case (decoded_alu_arithmetic_mux)
                        ADD: alu_out_reg <= rs + rt;
                        SUB: alu_out_reg <= rs - rt;
                        MUL: alu_out_reg <= rs * rt;
                        DIV: alu_out_reg <= (rt != 8'b0) ? (rs / rt) : 8'b0;
                        default: alu_out_reg <= 8'b0;
                    endcase
                end
            end
        end
    end
endmodule
