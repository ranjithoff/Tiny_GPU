`default_nettype none
`timescale 1ns/1ns

// INSTRUCTION FETCHER
// > Retrieves the instruction at the current PC from program memory
// > Each core has its own fetcher (Image 1: Fetcher block, shared across threads)
// > Image 2: Fetcher talks to Program Memory Controller → Program Memory
// > Three-state FSM: IDLE → FETCHING → FETCHED
//   IDLE:     waits for core_state == FETCH
//   FETCHING: waits for program memory ready signal
//   FETCHED:  holds instruction until core_state == DECODE, then resets
module fetcher #(
    parameter PROGRAM_MEM_ADDR_BITS = 8,
    parameter PROGRAM_MEM_DATA_BITS = 16
) (
    input wire        clk,
    input wire        reset,

    // From Scheduler (Image 1)
    input wire [2:0]  core_state,
    input wire [7:0]  current_pc,

    // Program Memory interface (Image 2: Program Memory Controller)
    output reg        mem_read_valid,
    output reg [PROGRAM_MEM_ADDR_BITS-1:0] mem_read_address,
    input wire        mem_read_ready,
    input wire [PROGRAM_MEM_DATA_BITS-1:0] mem_read_data,

    // Outputs to Scheduler and Decoder (Image 1)
    output reg [2:0]  fetcher_state,
    output reg [PROGRAM_MEM_DATA_BITS-1:0] instruction
);
    localparam IDLE     = 3'b000,
               FETCHING = 3'b001,
               FETCHED  = 3'b010;

    localparam CORE_FETCH  = 3'b001,
               CORE_DECODE = 3'b010;

    always @(posedge clk) begin
        if (reset) begin
            fetcher_state    <= IDLE;
            mem_read_valid   <= 1'b0;
            mem_read_address <= {PROGRAM_MEM_ADDR_BITS{1'b0}};
            instruction      <= {PROGRAM_MEM_DATA_BITS{1'b0}};
        end else begin
            case (fetcher_state)
                IDLE: begin
                    // Begin fetch when scheduler enters FETCH state
                    if (core_state == CORE_FETCH) begin
                        fetcher_state    <= FETCHING;
                        mem_read_valid   <= 1'b1;
                        mem_read_address <= current_pc;
                    end
                end
                FETCHING: begin
                    // Wait for program memory controller response
                    if (mem_read_ready) begin
                        fetcher_state  <= FETCHED;
                        instruction    <= mem_read_data;
                        mem_read_valid <= 1'b0;
                    end
                end
                FETCHED: begin
                    // Hold instruction; reset once decoder takes over
                    if (core_state == CORE_DECODE) begin
                        fetcher_state <= IDLE;
                    end
                end
                default: fetcher_state <= IDLE;
            endcase
        end
    end
endmodule
