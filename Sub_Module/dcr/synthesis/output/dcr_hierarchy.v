/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in topographical mode
// Version   : T-2022.03-SP4
// Date      : Mon Jul  6 11:14:32 2026
/////////////////////////////////////////////////////////////


module dcr ( clk, reset, device_control_write_enable, device_control_data, 
        thread_count );
  input [7:0] device_control_data;
  output [7:0] thread_count;
  input clk, reset, device_control_write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n11, n12;

  SAEDRVT14_FDP_V2_0P5 \dcr_reg_reg[7]  ( .D(n8), .CK(clk), .Q(thread_count[7]) );
  SAEDRVT14_FDP_V2_0P5 \dcr_reg_reg[6]  ( .D(n7), .CK(clk), .Q(thread_count[6]) );
  SAEDRVT14_FDP_V2_0P5 \dcr_reg_reg[5]  ( .D(n6), .CK(clk), .Q(thread_count[5]) );
  SAEDRVT14_FDP_V2_0P5 \dcr_reg_reg[4]  ( .D(n5), .CK(clk), .Q(thread_count[4]) );
  SAEDRVT14_FDP_V2_0P5 \dcr_reg_reg[3]  ( .D(n4), .CK(clk), .Q(thread_count[3]) );
  SAEDRVT14_FDP_V2_0P5 \dcr_reg_reg[2]  ( .D(n3), .CK(clk), .Q(thread_count[2]) );
  SAEDRVT14_FDP_V2_0P5 \dcr_reg_reg[1]  ( .D(n2), .CK(clk), .Q(thread_count[1]) );
  SAEDRVT14_FDP_V2_0P5 \dcr_reg_reg[0]  ( .D(n1), .CK(clk), .Q(thread_count[0]) );
  SAEDRVT14_AN2B_MM_1 U22 ( .B(device_control_write_enable), .A(reset), .X(n12) );
  SAEDRVT14_NR2_MM_1 U23 ( .A1(reset), .A2(device_control_write_enable), .X(
        n11) );
  SAEDRVT14_AO22_0P75 U24 ( .A1(n12), .A2(device_control_data[0]), .B1(n11), 
        .B2(thread_count[0]), .X(n1) );
  SAEDRVT14_AO22_0P75 U25 ( .A1(n12), .A2(device_control_data[6]), .B1(n11), 
        .B2(thread_count[6]), .X(n7) );
  SAEDRVT14_AO22_0P75 U26 ( .A1(n12), .A2(device_control_data[5]), .B1(n11), 
        .B2(thread_count[5]), .X(n6) );
  SAEDRVT14_AO22_0P75 U27 ( .A1(n12), .A2(device_control_data[4]), .B1(n11), 
        .B2(thread_count[4]), .X(n5) );
  SAEDRVT14_AO22_0P75 U28 ( .A1(n12), .A2(device_control_data[7]), .B1(n11), 
        .B2(thread_count[7]), .X(n8) );
  SAEDRVT14_AO22_0P75 U29 ( .A1(n12), .A2(device_control_data[3]), .B1(n11), 
        .B2(thread_count[3]), .X(n4) );
  SAEDRVT14_AO22_0P75 U30 ( .A1(n12), .A2(device_control_data[2]), .B1(n11), 
        .B2(thread_count[2]), .X(n3) );
  SAEDRVT14_AO22_0P75 U31 ( .A1(n12), .A2(device_control_data[1]), .B1(n11), 
        .B2(thread_count[1]), .X(n2) );
endmodule

