`default_nettype none
`timescale 1ns/1ns

// LOAD-STORE UNIT
// > Handles asynchronous memory load (LDR) and store (STR) operations
// > Each thread in each core has its own LSU (Image 1: LSU box per thread)
// > Image 2: LSU → Cache → Data Memory Controller → Data Memory
// > Image 3: LDR: Rd = global_data_mem[Rs]   STR: global_data_mem[Rs] = Rt
// > Image 4: mem_read_enable drives Load path; mem_write_enable drives Store path
// > FSM: IDLE → REQUESTING → WAITING → DONE
module lsu (
    input wire        clk,
    input wire        reset,
    input wire        enable,                   // Inactive when thread slot unused

    input wire [2:0]  core_state,              // From Scheduler
    input wire        decoded_mem_read_enable,  // LDR
    input wire        decoded_mem_write_enable, // STR

    // Source registers (Image 4: rs=address, rt=write data)
    input wire [7:0]  rs,
    input wire [7:0]  rt,

    // Data Memory interface (goes through Cache, then Data Memory Controller)
    output reg        mem_read_valid,
    output reg [7:0]  mem_read_address,
    input wire        mem_read_ready,
    input wire [7:0]  mem_read_data,

    output reg        mem_write_valid,
    output reg [7:0]  mem_write_address,
    output reg [7:0]  mem_write_data,
    input wire        mem_write_ready,

    // Outputs to Scheduler (wait check) and Registers (Image 4: lsu_out → rd)
    output reg [1:0]  lsu_state,
    output reg [7:0]  lsu_out
);
    localparam IDLE       = 2'b00,
               REQUESTING = 2'b01,
               WAITING    = 2'b10,
               DONE       = 2'b11;

    localparam CORE_REQUEST = 3'b011,
               CORE_UPDATE  = 3'b110;

    always @(posedge clk) begin
        if (reset) begin
            lsu_state         <= IDLE;
            lsu_out           <= 8'b0;
            mem_read_valid    <= 1'b0;
            mem_read_address  <= 8'b0;
            mem_write_valid   <= 1'b0;
            mem_write_address <= 8'b0;
            mem_write_data    <= 8'b0;
        end else if (enable) begin

            // ---- LDR path (Image 4: Load block) ----
            if (decoded_mem_read_enable) begin
                case (lsu_state)
                    IDLE: begin
                        if (core_state == CORE_REQUEST)
                            lsu_state <= REQUESTING;
                    end
                    REQUESTING: begin
                        mem_read_valid   <= 1'b1;
                        mem_read_address <= rs;      // Address = Rs (Image 3)
                        lsu_state        <= WAITING;
                    end
                    WAITING: begin
                        if (mem_read_ready) begin
                            mem_read_valid <= 1'b0;
                            lsu_out        <= mem_read_data;
                            lsu_state      <= DONE;
                        end
                    end
                    DONE: begin
                        if (core_state == CORE_UPDATE)
                            lsu_state <= IDLE;
                    end
                endcase
            end

            // ---- STR path (Image 4: Store block) ----
            else if (decoded_mem_write_enable) begin
                case (lsu_state)
                    IDLE: begin
                        if (core_state == CORE_REQUEST)
                            lsu_state <= REQUESTING;
                    end
                    REQUESTING: begin
                        mem_write_valid   <= 1'b1;
                        mem_write_address <= rs;     // Address = Rs (Image 3)
                        mem_write_data    <= rt;     // Data    = Rt (Image 3)
                        lsu_state         <= WAITING;
                    end
                    WAITING: begin
                        if (mem_write_ready) begin
                            mem_write_valid <= 1'b0;
                            lsu_state       <= DONE;
                        end
                    end
                    DONE: begin
                        if (core_state == CORE_UPDATE)
                            lsu_state <= IDLE;
                    end
                endcase
            end

            // ---- No memory op this cycle — stay IDLE ----
            else begin
                lsu_state         <= IDLE;
                mem_read_valid    <= 1'b0;
                mem_write_valid   <= 1'b0;
            end
        end
    end
endmodule
