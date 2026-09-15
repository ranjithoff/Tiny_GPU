`default_nettype none
`timescale 1ns/1ns

// INSTRUCTION DECODER
// > Decodes a 16-bit instruction into control signals used by ALU, LSU, PC, Registers
// > Each core has its own decoder (Image 1: Decoder block, shared across threads)
// > ISA matches Image 3 exactly:
//     [15:12] opcode  [11:8] Rd   [7:4] Rs   [3:0] Rt
//     BRnzp:  [15:12]=0001  [11:9]=nzp  [7:0]=IMM8
//     CONST:  [15:12]=1001  [11:8]=Rd   [7:0]=IMM8
// > Image 4: decoded signals drive alu_arithmetic_mux, alu_output_mux,
//   reg_input_mux, mem_read_enable, mem_write_enable, nzp_write_enable, pc_mux
module decoder (
    input wire        clk,
    input wire        reset,

    input wire [2:0]  core_state,   // From Scheduler — decode only in DECODE state
    input wire [15:0] instruction,  // Raw 16-bit instruction from Fetcher

    // Instruction fields (Image 3)
    output reg [3:0]  decoded_rd_address,
    output reg [3:0]  decoded_rs_address,
    output reg [3:0]  decoded_rt_address,
    output reg [2:0]  decoded_nzp,           // BRnzp condition bits
    output reg [7:0]  decoded_immediate,     // IMM8 field

    // Control signals (Image 4)
    output reg        decoded_reg_write_enable,
    output reg        decoded_mem_read_enable,
    output reg        decoded_mem_write_enable,
    output reg        decoded_nzp_write_enable,
    output reg [1:0]  decoded_reg_input_mux,      // 00=ALU 01=LSU 10=IMM
    output reg [1:0]  decoded_alu_arithmetic_mux, // 00=ADD 01=SUB 10=MUL 11=DIV
    output reg        decoded_alu_output_mux,      // 0=arithmetic 1=comparison
    output reg        decoded_pc_mux,              // 0=PC+1 1=branch IMM

    output reg        decoded_ret                  // RET instruction flag
);
    // Opcode encoding (Image 3)
    localparam NOP   = 4'b0000,
               BRnzp = 4'b0001,
               CMP   = 4'b0010,
               ADD   = 4'b0011,
               SUB   = 4'b0100,
               MUL   = 4'b0101,
               DIV   = 4'b0110,
               LDR   = 4'b0111,
               STR   = 4'b1000,
               CONST = 4'b1001,
               RET   = 4'b1111;

    // reg_input_mux encoding (Image 4: three inputs to rd mux)
    localparam MUX_ALU  = 2'b00,
               MUX_MEM  = 2'b01,
               MUX_IMM  = 2'b10;

    localparam DECODE = 3'b010;

    always @(posedge clk) begin
        if (reset) begin
            decoded_rd_address         <= 4'b0;
            decoded_rs_address         <= 4'b0;
            decoded_rt_address         <= 4'b0;
            decoded_immediate          <= 8'b0;
            decoded_nzp                <= 3'b0;
            decoded_reg_write_enable   <= 1'b0;
            decoded_mem_read_enable    <= 1'b0;
            decoded_mem_write_enable   <= 1'b0;
            decoded_nzp_write_enable   <= 1'b0;
            decoded_reg_input_mux      <= 2'b0;
            decoded_alu_arithmetic_mux <= 2'b0;
            decoded_alu_output_mux     <= 1'b0;
            decoded_pc_mux             <= 1'b0;
            decoded_ret                <= 1'b0;
        end else if (core_state == DECODE) begin
            // Decode instruction fields (Image 3 encoding)
            decoded_rd_address <= instruction[11:8];
            decoded_rs_address <= instruction[7:4];
            decoded_rt_address <= instruction[3:0];
            decoded_immediate  <= instruction[7:0];   // IMM8 (CONST / BRnzp)
            decoded_nzp        <= instruction[11:9];  // NZP bits for BRnzp

            // Default all control signals to 0, then set per opcode
            decoded_reg_write_enable   <= 1'b0;
            decoded_mem_read_enable    <= 1'b0;
            decoded_mem_write_enable   <= 1'b0;
            decoded_nzp_write_enable   <= 1'b0;
            decoded_reg_input_mux      <= 2'b0;
            decoded_alu_arithmetic_mux <= 2'b0;
            decoded_alu_output_mux     <= 1'b0;
            decoded_pc_mux             <= 1'b0;
            decoded_ret                <= 1'b0;

            case (instruction[15:12])
                NOP: begin
                    // PC = PC + 1, no other effect
                end
                BRnzp: begin
                    decoded_pc_mux <= 1'b1;           // Branch to IMM if NZP matches
                end
                CMP: begin
                    decoded_alu_output_mux   <= 1'b1; // Comparison output path
                    decoded_nzp_write_enable <= 1'b1; // Write result to NZP register
                end
                ADD: begin
                    decoded_reg_write_enable   <= 1'b1;
                    decoded_reg_input_mux      <= MUX_ALU;
                    decoded_alu_arithmetic_mux <= 2'b00; // ADD
                end
                SUB: begin
                    decoded_reg_write_enable   <= 1'b1;
                    decoded_reg_input_mux      <= MUX_ALU;
                    decoded_alu_arithmetic_mux <= 2'b01; // SUB
                end
                MUL: begin
                    decoded_reg_write_enable   <= 1'b1;
                    decoded_reg_input_mux      <= MUX_ALU;
                    decoded_alu_arithmetic_mux <= 2'b10; // MUL
                end
                DIV: begin
                    decoded_reg_write_enable   <= 1'b1;
                    decoded_reg_input_mux      <= MUX_ALU;
                    decoded_alu_arithmetic_mux <= 2'b11; // DIV
                end
                LDR: begin
                    decoded_reg_write_enable <= 1'b1;
                    decoded_reg_input_mux    <= MUX_MEM; // Rd = memory[Rs]
                    decoded_mem_read_enable  <= 1'b1;
                end
                STR: begin
                    decoded_mem_write_enable <= 1'b1;    // memory[Rs] = Rt
                end
                CONST: begin
                    decoded_reg_write_enable <= 1'b1;
                    decoded_reg_input_mux    <= MUX_IMM; // Rd = IMM8
                end
                RET: begin
                    decoded_ret <= 1'b1;
                end
                default: begin
                    // Treat unknown opcodes as NOP
                end
            endcase
        end
    end
endmodule
