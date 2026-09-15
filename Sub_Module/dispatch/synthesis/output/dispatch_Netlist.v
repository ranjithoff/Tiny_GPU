/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in topographical mode
// Version   : T-2022.03-SP4
// Date      : Mon Jul  6 11:21:25 2026
/////////////////////////////////////////////////////////////


module dispatch ( clk, reset, start, thread_count, core_done, core_start, 
        core_reset, .core_block_id({\core_block_id[3][7] , 
        \core_block_id[3][6] , \core_block_id[3][5] , \core_block_id[3][4] , 
        \core_block_id[3][3] , \core_block_id[3][2] , \core_block_id[3][1] , 
        \core_block_id[3][0] , \core_block_id[2][7] , \core_block_id[2][6] , 
        \core_block_id[2][5] , \core_block_id[2][4] , \core_block_id[2][3] , 
        \core_block_id[2][2] , \core_block_id[2][1] , \core_block_id[2][0] , 
        \core_block_id[1][7] , \core_block_id[1][6] , \core_block_id[1][5] , 
        \core_block_id[1][4] , \core_block_id[1][3] , \core_block_id[1][2] , 
        \core_block_id[1][1] , \core_block_id[1][0] , \core_block_id[0][7] , 
        \core_block_id[0][6] , \core_block_id[0][5] , \core_block_id[0][4] , 
        \core_block_id[0][3] , \core_block_id[0][2] , \core_block_id[0][1] , 
        \core_block_id[0][0] }), .core_thread_count({\core_thread_count[3][2] , 
        \core_thread_count[3][1] , \core_thread_count[3][0] , 
        \core_thread_count[2][2] , \core_thread_count[2][1] , 
        \core_thread_count[2][0] , \core_thread_count[1][2] , 
        \core_thread_count[1][1] , \core_thread_count[1][0] , 
        \core_thread_count[0][2] , \core_thread_count[0][1] , 
        \core_thread_count[0][0] }), done );
  input [7:0] thread_count;
  input [3:0] core_done;
  output [3:0] core_start;
  output [3:0] core_reset;
  input clk, reset, start;
  output \core_block_id[3][7] , \core_block_id[3][6] , \core_block_id[3][5] ,
         \core_block_id[3][4] , \core_block_id[3][3] , \core_block_id[3][2] ,
         \core_block_id[3][1] , \core_block_id[3][0] , \core_block_id[2][7] ,
         \core_block_id[2][6] , \core_block_id[2][5] , \core_block_id[2][4] ,
         \core_block_id[2][3] , \core_block_id[2][2] , \core_block_id[2][1] ,
         \core_block_id[2][0] , \core_block_id[1][7] , \core_block_id[1][6] ,
         \core_block_id[1][5] , \core_block_id[1][4] , \core_block_id[1][3] ,
         \core_block_id[1][2] , \core_block_id[1][1] , \core_block_id[1][0] ,
         \core_block_id[0][7] , \core_block_id[0][6] , \core_block_id[0][5] ,
         \core_block_id[0][4] , \core_block_id[0][3] , \core_block_id[0][2] ,
         \core_block_id[0][1] , \core_block_id[0][0] ,
         \core_thread_count[3][2] , \core_thread_count[3][1] ,
         \core_thread_count[3][0] , \core_thread_count[2][2] ,
         \core_thread_count[2][1] , \core_thread_count[2][0] ,
         \core_thread_count[1][2] , \core_thread_count[1][1] ,
         \core_thread_count[1][0] , \core_thread_count[0][2] ,
         \core_thread_count[0][1] , \core_thread_count[0][0] , done;
  wire   start_latch, n1, n2, n3, n4, n5, n8, n9, n10, n11, n12, n13, n14, n15,
         n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n28, n29, n30, n31,
         n32, n33, n34, n35, n36, n39, n40, n41, n42, n43, n44, n45, n46, n47,
         n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63,
         n64, n65, n67, n68, n69, n70, n128, n129, n131, n132, n133, n134,
         n136, n137, n138, n139, n140, n141, n142, n143, n144, n145, n146,
         n147, n148, n149, n150, n151, n152, n153, n154, n155, n156, n157,
         n158, n159, n160, n161, n162, n163, n164, n165, n166, n167, n168,
         n169, n170, n171, n172, n173, n174, n175, n176, n177, n178, n179,
         n181, n182, n183, n184, n185, n186, n187, n188, n189, n190, n191,
         n192, n193, n194, n195, n196, n197, n198, n199, n200, n201, n202,
         n203, n204, n205, n206, n207, n208, n209, n210, n211, n212, n213,
         n214, n215, n216, n217, n218, n219, n220, n221, n222, n223, n224,
         n225, n226, n227, n228, n229, n230, n231, n232, n233, n234, n235,
         n236, n237, n238, n239, n240, n241, n242, n243, n244, n245, n246,
         n247, n248, n249, n250, n251, n252, n253, n254, n255, n256, n257,
         n258, n259, n260, n261, n262, n264, n265, n266, n267, n268, n269,
         n270, n271, n273, n275, n276, n277, n278, n279, n280, n281, n282,
         n283, n284, n285, n286, n287, n288, n289, n290, n291, n292, n293,
         n294, n295, n296, n297, n298, n299, n300, n301, n302, n303, n304,
         n305, n306, n307, n308, n309, n310, n311, n312, n314, n315, n316,
         n317, n318, n319, n320, n321, n322, n323, n324, n325, n326, n327,
         n328, n329, n330, n331, n332, n333, n334, n335, n336, n337, n338,
         n339, n340, n341, n342, n343, n344, n345, n346, n347, n348, n349,
         n350, n351, n352, n353, n354, n355, n356, n357, n358, n360, n361,
         n362, n363, n364, n365, n366, n367, n368, n369, n370, n371, n372,
         n373, n374, n376, n377, n378, n379, n380, n381, n382, n383, n384,
         n385, n386, n387, n388, n389, n390, n391, n392, n393, n394, n395,
         n396, n397, n399, n400, n401, n402, n403, n404, n405, n406, n407,
         n408, n409, n410, n411, n412, n413, n414, n415, n416, n417, n418,
         n419, n420, n421, n422, n423, n424, n425, n426, n427, n428;
  wire   [7:0] blocks_dispatched;
  wire   [7:0] blocks_done;

  SAEDRVT14_FDP_V2_0P5 done_reg ( .D(n70), .CK(clk), .Q(done), .QN(n426) );
  SAEDRVT14_FDP_V2_0P5 start_latch_reg ( .D(n69), .CK(clk), .Q(start_latch), 
        .QN(n415) );
  SAEDRVT14_FDP_V2_0P5 \core_reset_reg[0]  ( .D(n68), .CK(clk), .Q(
        core_reset[0]), .QN(n419) );
  SAEDRVT14_FDP_V2_0P5 \blocks_dispatched_reg[0]  ( .D(n67), .CK(clk), .Q(
        blocks_dispatched[0]) );
  SAEDRVT14_FDP_V2_0P5 \blocks_dispatched_reg[5]  ( .D(n64), .CK(clk), .Q(
        blocks_dispatched[5]) );
  SAEDRVT14_FDP_V2_0P5 \blocks_dispatched_reg[2]  ( .D(n61), .CK(clk), .Q(
        blocks_dispatched[2]) );
  SAEDRVT14_FDP_V2_0P5 \blocks_dispatched_reg[1]  ( .D(n60), .CK(clk), .Q(
        blocks_dispatched[1]) );
  SAEDRVT14_FDP_V2_0P5 \core_reset_reg[3]  ( .D(n58), .CK(clk), .Q(
        core_reset[3]), .QN(n418) );
  SAEDRVT14_FDP_V2_0P5 \core_reset_reg[2]  ( .D(n56), .CK(clk), .Q(
        core_reset[2]), .QN(n417) );
  SAEDRVT14_FDP_V2_0P5 \core_reset_reg[1]  ( .D(n54), .CK(clk), .Q(
        core_reset[1]), .QN(n416) );
  SAEDRVT14_FDP_V2_0P5 \core_thread_count_reg[3][2]  ( .D(n52), .CK(clk), .Q(
        \core_thread_count[3][2] ), .QN(n414) );
  SAEDRVT14_FDP_V2_0P5 \core_thread_count_reg[3][1]  ( .D(n51), .CK(clk), .Q(
        \core_thread_count[3][1] ), .QN(n413) );
  SAEDRVT14_FDP_V2_0P5 \core_start_reg[0]  ( .D(n20), .CK(clk), .Q(
        core_start[0]), .QN(n408) );
  SAEDRVT14_FDP_V2_0P5 \blocks_done_reg[0]  ( .D(n19), .CK(clk), .Q(
        blocks_done[0]), .QN(n420) );
  SAEDRVT14_FDP_V2_0P5 \blocks_done_reg[7]  ( .D(n18), .CK(clk), .Q(
        blocks_done[7]), .QN(n411) );
  SAEDRVT14_FDP_V2_0P5 \blocks_done_reg[6]  ( .D(n17), .CK(clk), .Q(
        blocks_done[6]), .QN(n424) );
  SAEDRVT14_FDP_V2_0P5 \blocks_done_reg[5]  ( .D(n16), .CK(clk), .Q(
        blocks_done[5]), .QN(n423) );
  SAEDRVT14_FDP_V2_0P5 \blocks_done_reg[3]  ( .D(n14), .CK(clk), .Q(
        blocks_done[3]), .QN(n425) );
  SAEDRVT14_FDP_V2_0P5 \blocks_done_reg[2]  ( .D(n13), .CK(clk), .Q(
        blocks_done[2]), .QN(n421) );
  SAEDRVT14_FDP_V2_0P5 \blocks_done_reg[1]  ( .D(n12), .CK(clk), .Q(
        blocks_done[1]), .QN(n422) );
  SAEDRVT14_FDP_V2_0P5 \core_thread_count_reg[0][2]  ( .D(n10), .CK(clk), .Q(
        \core_thread_count[0][2] ), .QN(n407) );
  SAEDRVT14_FDP_V2_0P5 \core_thread_count_reg[0][1]  ( .D(n9), .CK(clk), .Q(
        \core_thread_count[0][1] ), .QN(n406) );
  SAEDRVT14_FDP_V2_0P5 \core_thread_count_reg[0][0]  ( .D(n8), .CK(clk), .Q(
        \core_thread_count[0][0] ), .QN(n405) );
  SAEDRVT14_FDP_V2LP_0P5 \core_block_id_reg[3][0]  ( .D(n53), .CK(clk), .Q(
        \core_block_id[3][0] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_block_id_reg[3][5]  ( .D(n47), .CK(clk), .Q(
        \core_block_id[3][5] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_block_id_reg[3][4]  ( .D(n46), .CK(clk), .Q(
        \core_block_id[3][4] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_block_id_reg[3][3]  ( .D(n45), .CK(clk), .Q(
        \core_block_id[3][3] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_block_id_reg[3][2]  ( .D(n44), .CK(clk), .Q(
        \core_block_id[3][2] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_block_id_reg[3][1]  ( .D(n43), .CK(clk), .Q(
        \core_block_id[3][1] ) );
  SAEDRVT14_FDP_V2LP_0P5 \blocks_dispatched_reg[6]  ( .D(n65), .CK(clk), .Q(
        blocks_dispatched[6]) );
  SAEDRVT14_FDP_V2LP_0P5 \core_block_id_reg[2][0]  ( .D(n42), .CK(clk), .Q(
        \core_block_id[2][0] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_block_id_reg[1][0]  ( .D(n31), .CK(clk), .Q(
        \core_block_id[1][0] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_block_id_reg[2][5]  ( .D(n36), .CK(clk), .Q(
        \core_block_id[2][5] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_block_id_reg[2][4]  ( .D(n35), .CK(clk), .Q(
        \core_block_id[2][4] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_block_id_reg[2][3]  ( .D(n34), .CK(clk), .Q(
        \core_block_id[2][3] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_block_id_reg[2][2]  ( .D(n33), .CK(clk), .Q(
        \core_block_id[2][2] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_block_id_reg[2][1]  ( .D(n32), .CK(clk), .Q(
        \core_block_id[2][1] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_block_id_reg[1][5]  ( .D(n25), .CK(clk), .Q(
        \core_block_id[1][5] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_block_id_reg[1][4]  ( .D(n24), .CK(clk), .Q(
        \core_block_id[1][4] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_block_id_reg[1][3]  ( .D(n23), .CK(clk), .Q(
        \core_block_id[1][3] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_block_id_reg[1][2]  ( .D(n22), .CK(clk), .Q(
        \core_block_id[1][2] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_block_id_reg[1][1]  ( .D(n21), .CK(clk), .Q(
        \core_block_id[1][1] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_block_id_reg[0][0]  ( .D(n11), .CK(clk), .Q(
        \core_block_id[0][0] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_block_id_reg[0][5]  ( .D(n5), .CK(clk), .Q(
        \core_block_id[0][5] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_block_id_reg[0][4]  ( .D(n4), .CK(clk), .Q(
        \core_block_id[0][4] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_block_id_reg[0][3]  ( .D(n3), .CK(clk), .Q(
        \core_block_id[0][3] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_block_id_reg[0][2]  ( .D(n2), .CK(clk), .Q(
        \core_block_id[0][2] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_block_id_reg[0][1]  ( .D(n1), .CK(clk), .Q(
        \core_block_id[0][1] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_start_reg[2]  ( .D(n57), .CK(clk), .Q(
        core_start[2]) );
  SAEDRVT14_FDP_V2LP_0P5 \core_start_reg[1]  ( .D(n55), .CK(clk), .Q(
        core_start[1]) );
  SAEDRVT14_FDP_V2LP_0P5 \core_thread_count_reg[2][2]  ( .D(n41), .CK(clk), 
        .Q(\core_thread_count[2][2] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_thread_count_reg[2][1]  ( .D(n40), .CK(clk), 
        .Q(\core_thread_count[2][1] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_thread_count_reg[2][0]  ( .D(n39), .CK(clk), 
        .Q(\core_thread_count[2][0] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_thread_count_reg[1][2]  ( .D(n30), .CK(clk), 
        .Q(\core_thread_count[1][2] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_thread_count_reg[1][1]  ( .D(n29), .CK(clk), 
        .Q(\core_thread_count[1][1] ) );
  SAEDRVT14_FDP_V2LP_0P5 \core_thread_count_reg[1][0]  ( .D(n28), .CK(clk), 
        .Q(\core_thread_count[1][0] ) );
  SAEDRVT14_OR2_0P75 U182 ( .A1(reset), .A2(core_reset[2]), .X(n172) );
  SAEDRVT14_ND3_4 U183 ( .A1(thread_count[2]), .A2(thread_count[3]), .A3(
        thread_count[6]), .X(n129) );
  SAEDRVT14_NR2_MM_16 U185 ( .A1(thread_count[1]), .A2(thread_count[0]), .X(
        n143) );
  SAEDRVT14_OR2_4 U186 ( .A1(n128), .A2(n143), .X(n131) );
  SAEDRVT14_NR2_MM_4 U187 ( .A1(n129), .A2(n131), .X(n163) );
  SAEDRVT14_ND2_8 U190 ( .A1(thread_count[3]), .A2(thread_count[2]), .X(n144)
         );
  SAEDRVT14_BUF_1 U191 ( .A(n144), .X(n132) );
  SAEDRVT14_INV_S_1 U193 ( .A(blocks_dispatched[4]), .X(n365) );
  SAEDRVT14_OAI21_V1_4 U194 ( .A1(n133), .A2(thread_count[6]), .B(n365), .X(
        n134) );
  SAEDRVT14_INV_S_1P5 U196 ( .A(n189), .X(n150) );
  SAEDRVT14_NR2_MM_4 U198 ( .A1(n371), .A2(blocks_dispatched[0]), .X(n149) );
  SAEDRVT14_INV_2 U200 ( .A(thread_count[2]), .X(n136) );
  SAEDRVT14_NR2_MM_4 U201 ( .A1(n143), .A2(n136), .X(n137) );
  SAEDRVT14_EO2_V1_1P5 U202 ( .A1(n138), .A2(n137), .X(n139) );
  SAEDRVT14_NR2_MM_4 U205 ( .A1(n142), .A2(n144), .X(n141) );
  SAEDRVT14_INV_2 U206 ( .A(n143), .X(n140) );
  SAEDRVT14_ND2_1 U207 ( .A1(n141), .A2(n140), .X(n151) );
  SAEDRVT14_OAI21_0P5 U208 ( .A1(n144), .A2(n143), .B(n142), .X(n145) );
  SAEDRVT14_INV_S_1 U210 ( .A(blocks_dispatched[1]), .X(n364) );
  SAEDRVT14_AOI21_1P5 U212 ( .A1(n152), .A2(blocks_dispatched[2]), .B(n146), 
        .X(n147) );
  SAEDRVT14_OAI21_V1_4 U213 ( .A1(n149), .A2(n148), .B(n147), .X(n182) );
  SAEDRVT14_ND2_CDC_4 U214 ( .A1(n150), .A2(n182), .X(n155) );
  SAEDRVT14_EO2_V1_1P5 U215 ( .A1(thread_count[5]), .A2(n151), .X(n154) );
  SAEDRVT14_OR2_0P75 U216 ( .A1(n152), .A2(blocks_dispatched[2]), .X(n153) );
  SAEDRVT14_NR2_MM_4 U218 ( .A1(n155), .A2(n186), .X(n171) );
  SAEDRVT14_INV_S_1 U219 ( .A(blocks_dispatched[3]), .X(n339) );
  SAEDRVT14_NR2_MM_4 U220 ( .A1(thread_count[5]), .A2(n339), .X(n156) );
  SAEDRVT14_INV_S_0P5 U221 ( .A(n156), .X(n159) );
  SAEDRVT14_NR2_MM_1 U222 ( .A1(thread_count[6]), .A2(n404), .X(n157) );
  SAEDRVT14_INV_S_0P5 U223 ( .A(n157), .X(n158) );
  SAEDRVT14_ND2_CDC_1 U224 ( .A1(n159), .A2(n158), .X(n183) );
  SAEDRVT14_INV_S_1 U226 ( .A(thread_count[7]), .X(n362) );
  SAEDRVT14_INV_S_0P5 U227 ( .A(n362), .X(n160) );
  SAEDRVT14_OR2_4 U228 ( .A1(n163), .A2(n160), .X(n164) );
  SAEDRVT14_NR2_MM_4 U230 ( .A1(n164), .A2(n342), .X(n187) );
  SAEDRVT14_INV_S_0P5 U231 ( .A(blocks_dispatched[6]), .X(n191) );
  SAEDRVT14_ND2_CDC_1 U232 ( .A1(start), .A2(n191), .X(n167) );
  SAEDRVT14_NR2_MM_4 U233 ( .A1(n187), .A2(n167), .X(n161) );
  SAEDRVT14_AOI21_0P75 U235 ( .A1(n163), .A2(thread_count[7]), .B(n342), .X(
        n166) );
  SAEDRVT14_INV_2 U236 ( .A(n164), .X(n165) );
  SAEDRVT14_NR2_MM_3 U237 ( .A1(n166), .A2(n165), .X(n188) );
  SAEDRVT14_INV_S_0P5 U238 ( .A(n167), .X(n168) );
  SAEDRVT14_OAI21_V1_4 U240 ( .A1(n171), .A2(n170), .B(n169), .X(n345) );
  SAEDRVT14_ND2_1 U241 ( .A1(n172), .A2(n345), .X(n401) );
  SAEDRVT14_INV_S_0P5 U242 ( .A(reset), .X(n173) );
  SAEDRVT14_ND2_CDC_1 U243 ( .A1(n173), .A2(start), .X(n179) );
  SAEDRVT14_AN2_1 U245 ( .A1(n427), .A2(blocks_dispatched[0]), .X(n321) );
  SAEDRVT14_OR2_0P75 U247 ( .A1(n401), .A2(n358), .X(n175) );
  SAEDRVT14_ND2_CDC_1 U248 ( .A1(n401), .A2(\core_block_id[2][0] ), .X(n174)
         );
  SAEDRVT14_ND2_CDC_1 U249 ( .A1(n175), .A2(n174), .X(n42) );
  SAEDRVT14_OR2_0P75 U250 ( .A1(reset), .A2(core_reset[1]), .X(n176) );
  SAEDRVT14_ND2_1 U251 ( .A1(n176), .A2(n345), .X(n390) );
  SAEDRVT14_OR2_0P75 U252 ( .A1(n390), .A2(n358), .X(n178) );
  SAEDRVT14_ND2_CDC_1 U253 ( .A1(n390), .A2(\core_block_id[1][0] ), .X(n177)
         );
  SAEDRVT14_ND2_CDC_1 U254 ( .A1(n178), .A2(n177), .X(n31) );
  SAEDRVT14_ND2_CDC_1 U255 ( .A1(blocks_dispatched[1]), .A2(
        blocks_dispatched[0]), .X(n315) );
  SAEDRVT14_OR2_0P75 U257 ( .A1(n315), .A2(n367), .X(n291) );
  SAEDRVT14_ND2_CDC_1 U261 ( .A1(n291), .A2(n427), .X(n326) );
  SAEDRVT14_INV_S_0P5 U262 ( .A(n326), .X(n196) );
  SAEDRVT14_OR2_0P75 U263 ( .A1(reset), .A2(core_reset[3]), .X(n181) );
  SAEDRVT14_NR2_MM_1 U266 ( .A1(n183), .A2(n187), .X(n184) );
  SAEDRVT14_OAI21_0P5 U267 ( .A1(n186), .A2(n185), .B(n184), .X(n195) );
  SAEDRVT14_AOI21_0P75 U269 ( .A1(n190), .A2(n189), .B(n188), .X(n194) );
  SAEDRVT14_OA31_1 U270 ( .A1(core_reset[2]), .A2(core_reset[1]), .A3(
        core_reset[0]), .B(n191), .X(n192) );
  SAEDRVT14_ND2_CDC_1 U271 ( .A1(start), .A2(n192), .X(n193) );
  SAEDRVT14_AOI21_1 U272 ( .A1(n195), .A2(n194), .B(n193), .X(n296) );
  SAEDRVT14_NR2_MM_8 U273 ( .A1(n378), .A2(n296), .X(n331) );
  SAEDRVT14_NR2_MM_1 U274 ( .A1(n196), .A2(n331), .X(n199) );
  SAEDRVT14_NR2_MM_1 U275 ( .A1(n291), .A2(blocks_dispatched[3]), .X(n197) );
  SAEDRVT14_ND2_CDC_1 U276 ( .A1(n197), .A2(n427), .X(n198) );
  SAEDRVT14_OAI22_0P75 U277 ( .A1(n199), .A2(n339), .B1(n331), .B2(n198), .X(
        n62) );
  SAEDRVT14_INV_S_0P5 U278 ( .A(blocks_dispatched[0]), .X(n373) );
  SAEDRVT14_ND2_CDC_1 U279 ( .A1(n373), .A2(n427), .X(n319) );
  SAEDRVT14_MUXI2_U_0P5 U280 ( .D0(n319), .D1(n373), .S(n331), .X(n67) );
  SAEDRVT14_ND2_CDC_1 U281 ( .A1(start), .A2(core_done[0]), .X(n380) );
  SAEDRVT14_OAI21_0P5 U283 ( .A1(n380), .A2(n408), .B(n360), .X(n245) );
  SAEDRVT14_INV_S_0P5 U284 ( .A(n245), .X(n204) );
  SAEDRVT14_ND2_CDC_1 U285 ( .A1(start), .A2(n415), .X(n205) );
  SAEDRVT14_INV_S_0P5 U286 ( .A(n205), .X(n202) );
  SAEDRVT14_INV_S_0P5 U287 ( .A(core_reset[0]), .X(n201) );
  SAEDRVT14_NR2_MM_1 U288 ( .A1(start), .A2(n419), .X(n200) );
  SAEDRVT14_AOI21_0P75 U289 ( .A1(n202), .A2(n201), .B(n200), .X(n203) );
  SAEDRVT14_ND2_CDC_1 U290 ( .A1(n204), .A2(n203), .X(n68) );
  SAEDRVT14_INV_S_0P5 U292 ( .A(core_reset[3]), .X(n207) );
  SAEDRVT14_OAI21_0P5 U293 ( .A1(start), .A2(n418), .B(n360), .X(n206) );
  SAEDRVT14_AOI21_0P75 U294 ( .A1(n217), .A2(n207), .B(n206), .X(n209) );
  SAEDRVT14_ND2_CDC_1 U295 ( .A1(start), .A2(core_done[3]), .X(n334) );
  SAEDRVT14_NR2_MM_1 U296 ( .A1(n334), .A2(n409), .X(n244) );
  SAEDRVT14_INV_S_0P5 U297 ( .A(n244), .X(n208) );
  SAEDRVT14_ND2_CDC_1 U298 ( .A1(n209), .A2(n208), .X(n58) );
  SAEDRVT14_INV_S_0P5 U299 ( .A(core_reset[2]), .X(n211) );
  SAEDRVT14_OAI21_0P5 U300 ( .A1(start), .A2(n417), .B(n360), .X(n210) );
  SAEDRVT14_AOI21_0P75 U301 ( .A1(n217), .A2(n211), .B(n210), .X(n214) );
  SAEDRVT14_ND2_CDC_1 U302 ( .A1(start), .A2(core_done[2]), .X(n400) );
  SAEDRVT14_INV_S_0P5 U303 ( .A(core_start[2]), .X(n212) );
  SAEDRVT14_NR2_MM_1 U304 ( .A1(n400), .A2(n212), .X(n247) );
  SAEDRVT14_INV_S_0P5 U305 ( .A(n247), .X(n213) );
  SAEDRVT14_ND2_CDC_1 U306 ( .A1(n214), .A2(n213), .X(n56) );
  SAEDRVT14_INV_S_0P5 U307 ( .A(core_reset[1]), .X(n216) );
  SAEDRVT14_OAI21_0P5 U308 ( .A1(start), .A2(n416), .B(n360), .X(n215) );
  SAEDRVT14_AOI21_0P75 U309 ( .A1(n217), .A2(n216), .B(n215), .X(n220) );
  SAEDRVT14_ND2_CDC_1 U310 ( .A1(start), .A2(core_done[1]), .X(n387) );
  SAEDRVT14_INV_S_0P5 U311 ( .A(core_start[1]), .X(n218) );
  SAEDRVT14_NR2_MM_1 U312 ( .A1(n387), .A2(n218), .X(n246) );
  SAEDRVT14_INV_S_0P5 U313 ( .A(n246), .X(n219) );
  SAEDRVT14_ND2_CDC_1 U314 ( .A1(n220), .A2(n219), .X(n54) );
  SAEDRVT14_EO2_1 U315 ( .A1(blocks_done[0]), .A2(n371), .X(n230) );
  SAEDRVT14_AOI21_0P75 U316 ( .A1(n362), .A2(blocks_done[6]), .B(
        blocks_done[7]), .X(n221) );
  SAEDRVT14_AN2_1 U317 ( .A1(n221), .A2(n427), .X(n224) );
  SAEDRVT14_ND2_CDC_1 U318 ( .A1(thread_count[2]), .A2(n420), .X(n222) );
  SAEDRVT14_EN3_1 U319 ( .A1(n222), .A2(thread_count[3]), .A3(n422), .X(n223)
         );
  SAEDRVT14_ND2_CDC_1 U320 ( .A1(n224), .A2(n223), .X(n228) );
  SAEDRVT14_INV_S_0P5 U321 ( .A(blocks_done[4]), .X(n252) );
  SAEDRVT14_ND2_CDC_1 U322 ( .A1(thread_count[6]), .A2(n252), .X(n225) );
  SAEDRVT14_EO2_1 U323 ( .A1(thread_count[7]), .A2(n225), .X(n235) );
  SAEDRVT14_ND2_CDC_1 U324 ( .A1(thread_count[7]), .A2(n424), .X(n226) );
  SAEDRVT14_AOI21_0P75 U325 ( .A1(n235), .A2(n226), .B(blocks_done[5]), .X(
        n227) );
  SAEDRVT14_NR2_MM_1 U326 ( .A1(n228), .A2(n227), .X(n229) );
  SAEDRVT14_ND2_CDC_1 U327 ( .A1(n230), .A2(n229), .X(n243) );
  SAEDRVT14_ND2_CDC_1 U328 ( .A1(thread_count[4]), .A2(n421), .X(n231) );
  SAEDRVT14_EN3_1 U329 ( .A1(n231), .A2(thread_count[5]), .A3(blocks_done[3]), 
        .X(n234) );
  SAEDRVT14_ND2_CDC_1 U330 ( .A1(thread_count[3]), .A2(n422), .X(n232) );
  SAEDRVT14_EN3_1 U331 ( .A1(n232), .A2(thread_count[4]), .A3(blocks_done[2]), 
        .X(n233) );
  SAEDRVT14_NR2_MM_1 U332 ( .A1(n234), .A2(n233), .X(n241) );
  SAEDRVT14_INV_S_0P5 U333 ( .A(n235), .X(n236) );
  SAEDRVT14_AOI21_0P75 U334 ( .A1(n236), .A2(n424), .B(n423), .X(n239) );
  SAEDRVT14_ND2_CDC_1 U335 ( .A1(thread_count[5]), .A2(n425), .X(n237) );
  SAEDRVT14_EN3_1 U336 ( .A1(n237), .A2(thread_count[6]), .A3(blocks_done[4]), 
        .X(n238) );
  SAEDRVT14_NR2_MM_1 U337 ( .A1(n239), .A2(n238), .X(n240) );
  SAEDRVT14_ND2_CDC_1 U338 ( .A1(n241), .A2(n240), .X(n242) );
  SAEDRVT14_OAI22_0P5 U339 ( .A1(n243), .A2(n242), .B1(reset), .B2(n426), .X(
        n70) );
  SAEDRVT14_NR2_MM_1 U340 ( .A1(n245), .A2(n244), .X(n249) );
  SAEDRVT14_NR2_MM_1 U341 ( .A1(n247), .A2(n246), .X(n248) );
  SAEDRVT14_ND2_CDC_1 U342 ( .A1(n249), .A2(n248), .X(n276) );
  SAEDRVT14_INV_S_1 U344 ( .A(blocks_done[1]), .X(n265) );
  SAEDRVT14_INV_S_0P5 U345 ( .A(blocks_done[2]), .X(n267) );
  SAEDRVT14_ND2_CDC_1 U347 ( .A1(n255), .A2(n427), .X(n250) );
  SAEDRVT14_ND2_CDC_1 U348 ( .A1(n276), .A2(n250), .X(n254) );
  SAEDRVT14_AOI21_0P75 U349 ( .A1(n427), .A2(n425), .B(n254), .X(n253) );
  SAEDRVT14_ND2_CDC_1 U350 ( .A1(n276), .A2(n427), .X(n273) );
  SAEDRVT14_INV_S_0P5 U351 ( .A(blocks_done[3]), .X(n257) );
  SAEDRVT14_NR2_MM_1 U352 ( .A1(n255), .A2(n257), .X(n271) );
  SAEDRVT14_ND2_CDC_1 U353 ( .A1(n410), .A2(n271), .X(n251) );
  SAEDRVT14_OAI22_0P5 U354 ( .A1(n253), .A2(n252), .B1(n273), .B2(n251), .X(
        n15) );
  SAEDRVT14_INV_S_0P5 U355 ( .A(n254), .X(n258) );
  SAEDRVT14_OR2_0P75 U356 ( .A1(blocks_done[3]), .A2(n255), .X(n256) );
  SAEDRVT14_OAI22_0P5 U357 ( .A1(n258), .A2(n257), .B1(n273), .B2(n256), .X(
        n14) );
  SAEDRVT14_ND2_CDC_1 U358 ( .A1(n270), .A2(n427), .X(n259) );
  SAEDRVT14_ND2_CDC_1 U359 ( .A1(n276), .A2(n259), .X(n264) );
  SAEDRVT14_INV_S_0P5 U360 ( .A(n264), .X(n262) );
  SAEDRVT14_INV_S_0P5 U361 ( .A(n270), .X(n260) );
  SAEDRVT14_ND2_CDC_1 U362 ( .A1(n260), .A2(n265), .X(n261) );
  SAEDRVT14_OAI22_0P5 U363 ( .A1(n262), .A2(n265), .B1(n273), .B2(n261), .X(
        n12) );
  SAEDRVT14_AOI21_0P75 U366 ( .A1(n427), .A2(n422), .B(n264), .X(n269) );
  SAEDRVT14_NR2_MM_1 U367 ( .A1(n270), .A2(n265), .X(n266) );
  SAEDRVT14_ND2_CDC_1 U368 ( .A1(n267), .A2(n266), .X(n268) );
  SAEDRVT14_OAI22_0P5 U369 ( .A1(n269), .A2(n421), .B1(n273), .B2(n268), .X(
        n13) );
  SAEDRVT14_OAI22_0P5 U370 ( .A1(n273), .A2(blocks_done[0]), .B1(n270), .B2(
        n276), .X(n19) );
  SAEDRVT14_NR2_MM_1 U373 ( .A1(n273), .A2(n428), .X(n280) );
  SAEDRVT14_INV_S_0P5 U374 ( .A(n280), .X(n278) );
  SAEDRVT14_ND2_CDC_1 U376 ( .A1(n428), .A2(n427), .X(n275) );
  SAEDRVT14_ND2_CDC_1 U377 ( .A1(n276), .A2(n275), .X(n284) );
  SAEDRVT14_INV_S_0P5 U378 ( .A(n284), .X(n277) );
  SAEDRVT14_OAI22_0P75 U379 ( .A1(n278), .A2(blocks_done[5]), .B1(n282), .B2(
        n277), .X(n16) );
  SAEDRVT14_INV_S_0P5 U380 ( .A(n282), .X(n279) );
  SAEDRVT14_ND2_CDC_1 U381 ( .A1(n280), .A2(n279), .X(n290) );
  SAEDRVT14_INV_S_0P5 U382 ( .A(blocks_done[7]), .X(n281) );
  SAEDRVT14_ND2_CDC_1 U383 ( .A1(blocks_done[6]), .A2(n281), .X(n287) );
  SAEDRVT14_AN2_1 U384 ( .A1(n427), .A2(n282), .X(n283) );
  SAEDRVT14_NR2_MM_1 U385 ( .A1(n284), .A2(n283), .X(n289) );
  SAEDRVT14_ND2_CDC_1 U386 ( .A1(n424), .A2(n427), .X(n285) );
  SAEDRVT14_AN2_1 U387 ( .A1(n289), .A2(n285), .X(n286) );
  SAEDRVT14_OAI22_0P5 U388 ( .A1(n290), .A2(n287), .B1(n286), .B2(n411), .X(
        n18) );
  SAEDRVT14_INV_S_0P5 U389 ( .A(blocks_done[6]), .X(n288) );
  SAEDRVT14_OAI22_0P5 U390 ( .A1(n290), .A2(blocks_done[6]), .B1(n289), .B2(
        n288), .X(n17) );
  SAEDRVT14_INV_S_0P5 U391 ( .A(blocks_dispatched[6]), .X(n298) );
  SAEDRVT14_INV_S_0P5 U392 ( .A(n291), .X(n292) );
  SAEDRVT14_AN2_1 U393 ( .A1(n292), .A2(blocks_dispatched[3]), .X(n293) );
  SAEDRVT14_AN2_1 U394 ( .A1(n427), .A2(n293), .X(n328) );
  SAEDRVT14_AN2_1 U395 ( .A1(blocks_dispatched[4]), .A2(blocks_dispatched[5]), 
        .X(n294) );
  SAEDRVT14_AN2_1 U396 ( .A1(n328), .A2(n294), .X(n295) );
  SAEDRVT14_OAI21_0P5 U397 ( .A1(n378), .A2(n296), .B(n295), .X(n297) );
  SAEDRVT14_OAI21_0P5 U398 ( .A1(n378), .A2(n298), .B(n297), .X(n65) );
  SAEDRVT14_ND2_CDC_1 U399 ( .A1(blocks_dispatched[5]), .A2(n427), .X(n356) );
  SAEDRVT14_ND2_CDC_1 U400 ( .A1(n390), .A2(\core_block_id[1][5] ), .X(n299)
         );
  SAEDRVT14_OAI21_0P5 U401 ( .A1(n356), .A2(n390), .B(n299), .X(n25) );
  SAEDRVT14_ND2_CDC_1 U402 ( .A1(n401), .A2(\core_block_id[2][5] ), .X(n300)
         );
  SAEDRVT14_OAI21_0P5 U403 ( .A1(n356), .A2(n401), .B(n300), .X(n36) );
  SAEDRVT14_ND2_CDC_1 U404 ( .A1(blocks_dispatched[3]), .A2(n427), .X(n350) );
  SAEDRVT14_ND2_CDC_1 U405 ( .A1(n390), .A2(\core_block_id[1][3] ), .X(n301)
         );
  SAEDRVT14_OAI21_0P5 U406 ( .A1(n350), .A2(n390), .B(n301), .X(n23) );
  SAEDRVT14_ND2_CDC_1 U407 ( .A1(blocks_dispatched[2]), .A2(n427), .X(n354) );
  SAEDRVT14_ND2_CDC_1 U408 ( .A1(n390), .A2(\core_block_id[1][2] ), .X(n302)
         );
  SAEDRVT14_OAI21_0P5 U409 ( .A1(n354), .A2(n390), .B(n302), .X(n22) );
  SAEDRVT14_ND2_CDC_1 U410 ( .A1(blocks_dispatched[1]), .A2(n427), .X(n352) );
  SAEDRVT14_ND2_CDC_1 U411 ( .A1(n390), .A2(\core_block_id[1][1] ), .X(n303)
         );
  SAEDRVT14_OAI21_0P5 U412 ( .A1(n352), .A2(n390), .B(n303), .X(n21) );
  SAEDRVT14_ND2_CDC_1 U413 ( .A1(n401), .A2(\core_block_id[2][2] ), .X(n304)
         );
  SAEDRVT14_OAI21_0P5 U414 ( .A1(n354), .A2(n401), .B(n304), .X(n33) );
  SAEDRVT14_ND2_CDC_1 U415 ( .A1(blocks_dispatched[4]), .A2(n427), .X(n348) );
  SAEDRVT14_ND2_CDC_1 U416 ( .A1(n390), .A2(\core_block_id[1][4] ), .X(n305)
         );
  SAEDRVT14_OAI21_0P5 U417 ( .A1(n348), .A2(n390), .B(n305), .X(n24) );
  SAEDRVT14_ND2_CDC_1 U418 ( .A1(n401), .A2(\core_block_id[2][4] ), .X(n306)
         );
  SAEDRVT14_OAI21_0P5 U419 ( .A1(n348), .A2(n401), .B(n306), .X(n35) );
  SAEDRVT14_ND2_CDC_1 U420 ( .A1(n401), .A2(\core_block_id[2][1] ), .X(n307)
         );
  SAEDRVT14_OAI21_0P5 U421 ( .A1(n352), .A2(n401), .B(n307), .X(n32) );
  SAEDRVT14_ND2_CDC_1 U422 ( .A1(n401), .A2(\core_block_id[2][3] ), .X(n308)
         );
  SAEDRVT14_OAI21_0P5 U423 ( .A1(n350), .A2(n401), .B(n308), .X(n34) );
  SAEDRVT14_AN2_1 U424 ( .A1(n427), .A2(n339), .X(n324) );
  SAEDRVT14_INV_S_0P5 U425 ( .A(n324), .X(n309) );
  SAEDRVT14_ND2_CDC_1 U426 ( .A1(n326), .A2(n309), .X(n310) );
  SAEDRVT14_NR2_MM_1 U427 ( .A1(n310), .A2(n331), .X(n312) );
  SAEDRVT14_ND2_CDC_1 U428 ( .A1(n365), .A2(n328), .X(n311) );
  SAEDRVT14_OAI22_1 U429 ( .A1(n312), .A2(n365), .B1(n331), .B2(n311), .X(n63)
         );
  SAEDRVT14_OAI21_0P5 U430 ( .A1(blocks_dispatched[1]), .A2(n179), .B(n319), 
        .X(n314) );
  SAEDRVT14_NR2_MM_1 U431 ( .A1(n331), .A2(n314), .X(n318) );
  SAEDRVT14_NR2_MM_1 U432 ( .A1(n315), .A2(blocks_dispatched[2]), .X(n316) );
  SAEDRVT14_ND2_CDC_1 U433 ( .A1(n316), .A2(n427), .X(n317) );
  SAEDRVT14_OAI22_0P5 U434 ( .A1(n318), .A2(n367), .B1(n331), .B2(n317), .X(
        n61) );
  SAEDRVT14_INV_S_0P5 U435 ( .A(n319), .X(n320) );
  SAEDRVT14_NR2_MM_1 U436 ( .A1(n331), .A2(n320), .X(n323) );
  SAEDRVT14_ND2_CDC_1 U437 ( .A1(n364), .A2(n321), .X(n322) );
  SAEDRVT14_OAI22_0P5 U438 ( .A1(n323), .A2(n364), .B1(n331), .B2(n322), .X(
        n60) );
  SAEDRVT14_AOI21_0P75 U439 ( .A1(n427), .A2(n365), .B(n324), .X(n325) );
  SAEDRVT14_ND2_CDC_1 U440 ( .A1(n326), .A2(n325), .X(n327) );
  SAEDRVT14_NR2_MM_1 U441 ( .A1(n331), .A2(n327), .X(n332) );
  SAEDRVT14_NR2_MM_1 U442 ( .A1(n365), .A2(blocks_dispatched[5]), .X(n329) );
  SAEDRVT14_ND2_CDC_1 U443 ( .A1(n329), .A2(n328), .X(n330) );
  SAEDRVT14_OAI22_0P5 U444 ( .A1(n332), .A2(n342), .B1(n331), .B2(n330), .X(
        n64) );
  SAEDRVT14_ND2_MM_1 U445 ( .A1(n378), .A2(n427), .X(n344) );
  SAEDRVT14_INV_S_0P5 U446 ( .A(\core_block_id[3][0] ), .X(n333) );
  SAEDRVT14_OAI22_0P5 U447 ( .A1(n344), .A2(n373), .B1(n378), .B2(n333), .X(
        n53) );
  SAEDRVT14_AN2_1 U448 ( .A1(core_done[3]), .A2(core_start[3]), .X(n336) );
  SAEDRVT14_ND2_CDC_1 U449 ( .A1(n334), .A2(core_start[3]), .X(n335) );
  SAEDRVT14_OAI22_0P75 U450 ( .A1(n344), .A2(n336), .B1(n378), .B2(n335), .X(
        n59) );
  SAEDRVT14_INV_S_0P5 U451 ( .A(\core_block_id[3][2] ), .X(n337) );
  SAEDRVT14_OAI22_0P5 U452 ( .A1(n344), .A2(n367), .B1(n378), .B2(n337), .X(
        n44) );
  SAEDRVT14_INV_S_0P5 U453 ( .A(\core_block_id[3][3] ), .X(n338) );
  SAEDRVT14_OAI22_0P5 U454 ( .A1(n344), .A2(n339), .B1(n378), .B2(n338), .X(
        n45) );
  SAEDRVT14_INV_S_0P5 U455 ( .A(\core_block_id[3][4] ), .X(n340) );
  SAEDRVT14_OAI22_0P5 U456 ( .A1(n344), .A2(n365), .B1(n378), .B2(n340), .X(
        n46) );
  SAEDRVT14_INV_S_0P5 U457 ( .A(\core_block_id[3][5] ), .X(n341) );
  SAEDRVT14_OAI22_0P5 U458 ( .A1(n344), .A2(n342), .B1(n378), .B2(n341), .X(
        n47) );
  SAEDRVT14_INV_S_0P5 U459 ( .A(\core_block_id[3][1] ), .X(n343) );
  SAEDRVT14_OAI22_0P5 U460 ( .A1(n344), .A2(n364), .B1(n378), .B2(n343), .X(
        n43) );
  SAEDRVT14_OR2_0P75 U461 ( .A1(reset), .A2(core_reset[0]), .X(n346) );
  SAEDRVT14_ND2_1 U462 ( .A1(n346), .A2(n345), .X(n383) );
  SAEDRVT14_ND2_CDC_1 U463 ( .A1(n383), .A2(\core_block_id[0][4] ), .X(n347)
         );
  SAEDRVT14_OAI21_0P5 U464 ( .A1(n383), .A2(n348), .B(n347), .X(n4) );
  SAEDRVT14_ND2_CDC_1 U465 ( .A1(n383), .A2(\core_block_id[0][3] ), .X(n349)
         );
  SAEDRVT14_OAI21_0P5 U466 ( .A1(n383), .A2(n350), .B(n349), .X(n3) );
  SAEDRVT14_ND2_CDC_1 U467 ( .A1(n383), .A2(\core_block_id[0][1] ), .X(n351)
         );
  SAEDRVT14_OAI21_0P5 U468 ( .A1(n383), .A2(n352), .B(n351), .X(n1) );
  SAEDRVT14_ND2_CDC_1 U469 ( .A1(n383), .A2(\core_block_id[0][2] ), .X(n353)
         );
  SAEDRVT14_OAI21_0P5 U470 ( .A1(n383), .A2(n354), .B(n353), .X(n2) );
  SAEDRVT14_ND2_CDC_1 U471 ( .A1(n383), .A2(\core_block_id[0][5] ), .X(n355)
         );
  SAEDRVT14_OAI21_0P5 U472 ( .A1(n383), .A2(n356), .B(n355), .X(n5) );
  SAEDRVT14_ND2_CDC_1 U473 ( .A1(n383), .A2(\core_block_id[0][0] ), .X(n357)
         );
  SAEDRVT14_OAI21_0P5 U474 ( .A1(n383), .A2(n358), .B(n357), .X(n11) );
  SAEDRVT14_AO21_1 U475 ( .A1(start_latch), .A2(n360), .B(n427), .X(n69) );
  SAEDRVT14_AN2_MM_1 U476 ( .A1(n427), .A2(thread_count[0]), .X(n372) );
  SAEDRVT14_OAI22_0P5 U478 ( .A1(blocks_dispatched[5]), .A2(n362), .B1(n361), 
        .B2(blocks_dispatched[3]), .X(n363) );
  SAEDRVT14_AOI21_0P75 U479 ( .A1(thread_count[3]), .A2(n364), .B(n363), .X(
        n369) );
  SAEDRVT14_AN2_MM_1 U480 ( .A1(thread_count[6]), .A2(n365), .X(n366) );
  SAEDRVT14_AOI21_0P75 U481 ( .A1(thread_count[4]), .A2(n367), .B(n366), .X(
        n368) );
  SAEDRVT14_ND2_CDC_1 U482 ( .A1(n369), .A2(n368), .X(n370) );
  SAEDRVT14_AOI21_0P75 U483 ( .A1(n373), .A2(n371), .B(n370), .X(n376) );
  SAEDRVT14_ND2_CDC_1 U484 ( .A1(n372), .A2(n376), .X(n395) );
  SAEDRVT14_MUXI2_U_0P5 U485 ( .D0(n412), .D1(n395), .S(n378), .X(n50) );
  SAEDRVT14_AOI21_0P75 U486 ( .A1(thread_count[2]), .A2(n373), .B(reset), .X(
        n374) );
  SAEDRVT14_AN2_1 U487 ( .A1(n376), .A2(n374), .X(n397) );
  SAEDRVT14_MUXI2_U_0P5 U488 ( .D0(n414), .D1(n397), .S(n378), .X(n52) );
  SAEDRVT14_ND2_CDC_1 U490 ( .A1(n377), .A2(n376), .X(n393) );
  SAEDRVT14_MUXI2_U_0P5 U491 ( .D0(n413), .D1(n393), .S(n378), .X(n51) );
  SAEDRVT14_MUXI2_U_0P5 U492 ( .D0(n393), .D1(n406), .S(n383), .X(n9) );
  SAEDRVT14_MUXI2_U_0P5 U493 ( .D0(n397), .D1(n407), .S(n383), .X(n10) );
  SAEDRVT14_ND2_CDC_1 U494 ( .A1(core_done[0]), .A2(core_start[0]), .X(n379)
         );
  SAEDRVT14_ND2_CDC_1 U495 ( .A1(n379), .A2(n427), .X(n382) );
  SAEDRVT14_ND2_CDC_1 U496 ( .A1(n380), .A2(core_start[0]), .X(n381) );
  SAEDRVT14_MUXI2_U_0P5 U497 ( .D0(n382), .D1(n381), .S(n383), .X(n20) );
  SAEDRVT14_MUXI2_U_0P5 U498 ( .D0(n395), .D1(n405), .S(n383), .X(n8) );
  SAEDRVT14_INV_S_0P5 U499 ( .A(\core_thread_count[1][2] ), .X(n384) );
  SAEDRVT14_MUXI2_U_0P5 U500 ( .D0(n397), .D1(n384), .S(n390), .X(n30) );
  SAEDRVT14_INV_S_0P5 U501 ( .A(\core_thread_count[1][1] ), .X(n385) );
  SAEDRVT14_MUXI2_U_0P5 U502 ( .D0(n393), .D1(n385), .S(n390), .X(n29) );
  SAEDRVT14_ND2_CDC_1 U503 ( .A1(core_done[1]), .A2(core_start[1]), .X(n386)
         );
  SAEDRVT14_ND2_CDC_1 U504 ( .A1(n386), .A2(n427), .X(n389) );
  SAEDRVT14_ND2_CDC_1 U505 ( .A1(n387), .A2(core_start[1]), .X(n388) );
  SAEDRVT14_MUXI2_U_0P5 U506 ( .D0(n389), .D1(n388), .S(n390), .X(n55) );
  SAEDRVT14_INV_S_0P5 U507 ( .A(\core_thread_count[1][0] ), .X(n391) );
  SAEDRVT14_MUXI2_U_0P5 U508 ( .D0(n395), .D1(n391), .S(n390), .X(n28) );
  SAEDRVT14_INV_S_0P5 U509 ( .A(\core_thread_count[2][1] ), .X(n392) );
  SAEDRVT14_MUXI2_U_0P5 U510 ( .D0(n393), .D1(n392), .S(n401), .X(n40) );
  SAEDRVT14_INV_S_0P5 U511 ( .A(\core_thread_count[2][0] ), .X(n394) );
  SAEDRVT14_MUXI2_U_0P5 U512 ( .D0(n395), .D1(n394), .S(n401), .X(n39) );
  SAEDRVT14_INV_S_0P5 U513 ( .A(\core_thread_count[2][2] ), .X(n396) );
  SAEDRVT14_MUXI2_U_0P5 U514 ( .D0(n397), .D1(n396), .S(n401), .X(n41) );
  SAEDRVT14_ND2_CDC_1 U515 ( .A1(core_done[2]), .A2(core_start[2]), .X(n399)
         );
  SAEDRVT14_ND2_CDC_1 U516 ( .A1(n399), .A2(n427), .X(n403) );
  SAEDRVT14_ND2_CDC_1 U517 ( .A1(n400), .A2(core_start[2]), .X(n402) );
  SAEDRVT14_MUXI2_U_0P5 U518 ( .D0(n403), .D1(n402), .S(n401), .X(n57) );
  SAEDRVT14_INV_2 U244 ( .A(n179), .X(n427) );
  SAEDRVT14_FDP_V2LP_0P5 \blocks_done_reg[4]  ( .D(n15), .CK(clk), .Q(
        blocks_done[4]), .QN(n410) );
  SAEDRVT14_FDP_V2LP_0P5 \blocks_dispatched_reg[4]  ( .D(n63), .CK(clk), .Q(
        blocks_dispatched[4]), .QN(n404) );
  SAEDRVT14_FDP_V2LP_0P5 \blocks_dispatched_reg[3]  ( .D(n62), .CK(clk), .Q(
        blocks_dispatched[3]) );
  SAEDRVT14_FDP_V2LP_0P5 \core_thread_count_reg[3][0]  ( .D(n50), .CK(clk), 
        .Q(\core_thread_count[3][0] ), .QN(n412) );
  SAEDRVT14_FDP_V2LP_0P5 \core_start_reg[3]  ( .D(n59), .CK(clk), .Q(
        core_start[3]), .QN(n409) );
  SAEDRVT14_AN2_8 U264 ( .A1(n345), .A2(n181), .X(n378) );
  SAEDRVT14_AOI21_1P5 U239 ( .A1(n188), .A2(n168), .B(reset), .X(n169) );
  SAEDRVT14_OAI21_3 U234 ( .A1(n162), .A2(n189), .B(n161), .X(n170) );
  SAEDRVT14_OAI21_3 U217 ( .A1(n154), .A2(blocks_dispatched[3]), .B(n153), .X(
        n186) );
  SAEDRVT14_NR2_MM_3 U203 ( .A1(n139), .A2(blocks_dispatched[1]), .X(n148) );
  SAEDRVT14_NR2_MM_3 U195 ( .A1(n163), .A2(n134), .X(n189) );
  SAEDRVT14_NR2_MM_1 U211 ( .A1(thread_count[3]), .A2(n364), .X(n146) );
  SAEDRVT14_EO2_V1_1P5 U197 ( .A1(thread_count[2]), .A2(n143), .X(n371) );
  SAEDRVT14_NR2_MM_3 U192 ( .A1(n132), .A2(n131), .X(n133) );
  SAEDRVT14_ND2_MM_2 U184 ( .A1(thread_count[4]), .A2(thread_count[5]), .X(
        n128) );
  SAEDRVT14_INV_S_0P5 U291 ( .A(n205), .X(n217) );
  SAEDRVT14_INV_S_0P5 U246 ( .A(n321), .X(n358) );
  SAEDRVT14_AN2_1 U489 ( .A1(n427), .A2(thread_count[1]), .X(n377) );
  SAEDRVT14_INV_S_0P5 U375 ( .A(blocks_done[5]), .X(n282) );
  SAEDRVT14_INV_S_0P5 U268 ( .A(n187), .X(n190) );
  SAEDRVT14_INV_S_0P5 U265 ( .A(n182), .X(n185) );
  SAEDRVT14_INV_S_0P5 U477 ( .A(thread_count[5]), .X(n361) );
  SAEDRVT14_INV_S_0P5 U225 ( .A(n183), .X(n162) );
  SAEDRVT14_INV_S_0P5 U282 ( .A(reset), .X(n360) );
  SAEDRVT14_INV_S_0P5 U256 ( .A(blocks_dispatched[2]), .X(n367) );
  SAEDRVT14_INV_S_0P5 U229 ( .A(blocks_dispatched[5]), .X(n342) );
  SAEDRVT14_OR3_0P5 U346 ( .A1(n270), .A2(n265), .A3(n267), .X(n255) );
  SAEDRVT14_INV_S_0P5 U343 ( .A(blocks_done[0]), .X(n270) );
  SAEDRVT14_ND2_1 U209 ( .A1(n151), .A2(n145), .X(n152) );
  SAEDRVT14_INV_S_1 U199 ( .A(thread_count[3]), .X(n138) );
  SAEDRVT14_INV_2 U204 ( .A(thread_count[4]), .X(n142) );
  SAEDRVT14_TIE0_V1_2 U188 ( .X(\core_block_id[3][7] ) );
  SAEDRVT14_TIE0_V1_2 U189 ( .X(\core_block_id[3][6] ) );
  SAEDRVT14_TIE0_V1_2 U258 ( .X(\core_block_id[2][7] ) );
  SAEDRVT14_TIE0_V1_2 U259 ( .X(\core_block_id[2][6] ) );
  SAEDRVT14_TIE0_V1_2 U260 ( .X(\core_block_id[1][7] ) );
  SAEDRVT14_TIE0_V1_2 U364 ( .X(\core_block_id[1][6] ) );
  SAEDRVT14_TIE0_V1_2 U365 ( .X(\core_block_id[0][7] ) );
  SAEDRVT14_TIE0_V1_2 U371 ( .X(\core_block_id[0][6] ) );
  SAEDRVT14_ND2_CDC_1 U372 ( .A1(blocks_done[4]), .A2(n271), .X(n428) );
endmodule

