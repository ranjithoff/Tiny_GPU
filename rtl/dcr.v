`default_nettype none
`timescale 1ns/1ns

// DEVICE CONTROL REGISTER
// > Configures kernel execution parameters (Image 2: Device Control Register block)
// > Written by the host before asserting start; holds the total thread count
// > thread_count is read by the Dispatcher to compute total_blocks
module dcr (
    input  wire       clk,
    input  wire       reset,

    input  wire       device_control_write_enable,
    input  wire [7:0] device_control_data,
    output wire [7:0] thread_count
);
    reg [7:0] dcr_reg;
    assign thread_count = dcr_reg;

    always @(posedge clk) begin
        if (reset) begin
            dcr_reg <= 8'b0;
        end else if (device_control_write_enable) begin
            dcr_reg <= device_control_data;
        end
    end
endmodule
