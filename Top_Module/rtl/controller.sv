`default_nettype none
`timescale 1ns/1ns

// MEMORY CONTROLLER
// > Arbitrates between multiple consumers (LSUs or Fetchers) and limited
//   external memory channels (Image 2: Program/Data Memory Controllers)
// > Round-robin channel assignment: each idle channel scans for a pending request
// > WRITE_ENABLE=0 for program memory controller (read-only)
// > Flow per channel:
//     IDLE         → scan consumers for pending read or write request
//     READ_WAITING → forward read to memory; wait for mem_read_ready
//     WRITE_WAITING→ forward write to memory; wait for mem_write_ready
//     READ_RELAYING → hold data for consumer until consumer deasserts valid
//     WRITE_RELAYING→ hold ready for consumer until consumer deasserts valid
module controller #(
    parameter ADDR_BITS      = 8,
    parameter DATA_BITS      = 16,
    parameter NUM_CONSUMERS  = 4,
    parameter NUM_CHANNELS   = 1,
    parameter WRITE_ENABLE   = 1
) (
    input wire clk,
    input wire reset,

    // Consumer Interface (LSUs / Fetchers)
    input  wire [NUM_CONSUMERS-1:0]              consumer_read_valid,
    input  wire [ADDR_BITS-1:0]                  consumer_read_address  [NUM_CONSUMERS-1:0],
    output reg  [NUM_CONSUMERS-1:0]              consumer_read_ready,
    output reg  [DATA_BITS-1:0]                  consumer_read_data     [NUM_CONSUMERS-1:0],

    input  wire [NUM_CONSUMERS-1:0]              consumer_write_valid,
    input  wire [ADDR_BITS-1:0]                  consumer_write_address [NUM_CONSUMERS-1:0],
    input  wire [DATA_BITS-1:0]                  consumer_write_data    [NUM_CONSUMERS-1:0],
    output reg  [NUM_CONSUMERS-1:0]              consumer_write_ready,

    // Memory Interface (Global Program / Data Memory)
    output reg  [NUM_CHANNELS-1:0]               mem_read_valid,
    output reg  [ADDR_BITS-1:0]                  mem_read_address       [NUM_CHANNELS-1:0],
    input  wire [NUM_CHANNELS-1:0]               mem_read_ready,
    input  wire [DATA_BITS-1:0]                  mem_read_data          [NUM_CHANNELS-1:0],

    output reg  [NUM_CHANNELS-1:0]               mem_write_valid,
    output reg  [ADDR_BITS-1:0]                  mem_write_address      [NUM_CHANNELS-1:0],
    output reg  [DATA_BITS-1:0]                  mem_write_data         [NUM_CHANNELS-1:0],
    input  wire [NUM_CHANNELS-1:0]               mem_write_ready
);
    localparam IDLE           = 3'b000,
               READ_WAITING  = 3'b010,
               WRITE_WAITING = 3'b011,
               READ_RELAYING = 3'b100,
               WRITE_RELAYING= 3'b101;

    reg [2:0]                          ch_state        [NUM_CHANNELS-1:0];
    reg [$clog2(NUM_CONSUMERS)-1:0]    current_consumer[NUM_CHANNELS-1:0];
    reg [NUM_CONSUMERS-1:0]            ch_serving;  // Tracks which consumers are already served

    integer i, j;
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < NUM_CHANNELS; i = i + 1) begin
                ch_state[i]         <= IDLE;
                current_consumer[i] <= {$clog2(NUM_CONSUMERS){1'b0}};
                mem_read_valid[i]   <= 1'b0;
                mem_write_valid[i]  <= 1'b0;
                mem_read_address[i] <= {ADDR_BITS{1'b0}};
                mem_write_address[i]<= {ADDR_BITS{1'b0}};
                mem_write_data[i]   <= {DATA_BITS{1'b0}};
            end
            consumer_read_ready  <= {NUM_CONSUMERS{1'b0}};
            consumer_write_ready <= {NUM_CONSUMERS{1'b0}};
            for (j = 0; j < NUM_CONSUMERS; j = j + 1)
                consumer_read_data[j] <= {DATA_BITS{1'b0}};
            ch_serving <= {NUM_CONSUMERS{1'b0}};
        end else begin
            for (i = 0; i < NUM_CHANNELS; i = i + 1) begin
                case (ch_state[i])

                    IDLE: begin
                        // Scan for a consumer with a pending request (not already served)
                        for (j = 0; j < NUM_CONSUMERS; j = j + 1) begin
                            if (consumer_read_valid[j] && !ch_serving[j]) begin
                                ch_serving[j]       <= 1'b1;
                                current_consumer[i] <= j[$clog2(NUM_CONSUMERS)-1:0];
                                mem_read_valid[i]   <= 1'b1;
                                mem_read_address[i] <= consumer_read_address[j];
                                ch_state[i]         <= READ_WAITING;
                            end else if (WRITE_ENABLE && consumer_write_valid[j] && !ch_serving[j]) begin
                                ch_serving[j]        <= 1'b1;
                                current_consumer[i]  <= j[$clog2(NUM_CONSUMERS)-1:0];
                                mem_write_valid[i]   <= 1'b1;
                                mem_write_address[i] <= consumer_write_address[j];
                                mem_write_data[i]    <= consumer_write_data[j];
                                ch_state[i]          <= WRITE_WAITING;
                            end
                        end
                    end

                    READ_WAITING: begin
                        if (mem_read_ready[i]) begin
                            mem_read_valid[i]                               <= 1'b0;
                            consumer_read_ready[current_consumer[i]]        <= 1'b1;
                            consumer_read_data[current_consumer[i]]         <= mem_read_data[i];
                            ch_state[i]                                     <= READ_RELAYING;
                        end
                    end

                    WRITE_WAITING: begin
                        if (mem_write_ready[i]) begin
                            mem_write_valid[i]                              <= 1'b0;
                            consumer_write_ready[current_consumer[i]]       <= 1'b1;
                            ch_state[i]                                     <= WRITE_RELAYING;
                        end
                    end

                    READ_RELAYING: begin
                        // Wait for consumer to deassert its read request
                        if (!consumer_read_valid[current_consumer[i]]) begin
                            ch_serving[current_consumer[i]]           <= 1'b0;
                            consumer_read_ready[current_consumer[i]]  <= 1'b0;
                            ch_state[i]                               <= IDLE;
                        end
                    end

                    WRITE_RELAYING: begin
                        if (!consumer_write_valid[current_consumer[i]]) begin
                            ch_serving[current_consumer[i]]           <= 1'b0;
                            consumer_write_ready[current_consumer[i]] <= 1'b0;
                            ch_state[i]                               <= IDLE;
                        end
                    end

                    default: ch_state[i] <= IDLE;
                endcase
            end
        end
    end
endmodule
