if { [namespace current] != {::6A4B425D} } { error {This script [file tail [info script]] should not be sourced directly}; }
###################################################################

# Created by write_script -format dctcl for scenario constraints on Mon Jul  6 \
11:21:25 2026

###################################################################

# Set the current_design #
current_design dispatch


set_tlu_plus_files -max_tluplus                                                \
/home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_TECH_DATA/tlup/saed14nm_1p9m_Cmax.tlup \
-min_tluplus                                                                   \
/home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_TECH_DATA/tlup/saed14nm_1p9m_Cmin.tlup \
-tech2itf_map                                                                  \
/home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_TECH_DATA/map/saed14nm_tf_itf_tluplus.map \

set_operating_conditions ss0p72v25c -library saed14lvt_base_ss0p72v25c
set_max_fanout 200 [current_design]
set_max_transition 0.1 [current_design]
set_max_capacitance 102 [current_design]
set_load -pin_load 0.004 [get_ports {core_start[3]}]
set_load -pin_load 0.004 [get_ports {core_start[2]}]
set_load -pin_load 0.004 [get_ports {core_start[1]}]
set_load -pin_load 0.004 [get_ports {core_start[0]}]
set_load -pin_load 0.004 [get_ports {core_reset[3]}]
set_load -pin_load 0.004 [get_ports {core_reset[2]}]
set_load -pin_load 0.004 [get_ports {core_reset[1]}]
set_load -pin_load 0.004 [get_ports {core_reset[0]}]
set_load -pin_load 0.004 [get_ports {core_block_id[3][7]}]
set_load -pin_load 0.004 [get_ports {core_block_id[3][6]}]
set_load -pin_load 0.004 [get_ports {core_block_id[3][5]}]
set_load -pin_load 0.004 [get_ports {core_block_id[3][4]}]
set_load -pin_load 0.004 [get_ports {core_block_id[3][3]}]
set_load -pin_load 0.004 [get_ports {core_block_id[3][2]}]
set_load -pin_load 0.004 [get_ports {core_block_id[3][1]}]
set_load -pin_load 0.004 [get_ports {core_block_id[3][0]}]
set_load -pin_load 0.004 [get_ports {core_block_id[2][7]}]
set_load -pin_load 0.004 [get_ports {core_block_id[2][6]}]
set_load -pin_load 0.004 [get_ports {core_block_id[2][5]}]
set_load -pin_load 0.004 [get_ports {core_block_id[2][4]}]
set_load -pin_load 0.004 [get_ports {core_block_id[2][3]}]
set_load -pin_load 0.004 [get_ports {core_block_id[2][2]}]
set_load -pin_load 0.004 [get_ports {core_block_id[2][1]}]
set_load -pin_load 0.004 [get_ports {core_block_id[2][0]}]
set_load -pin_load 0.004 [get_ports {core_block_id[1][7]}]
set_load -pin_load 0.004 [get_ports {core_block_id[1][6]}]
set_load -pin_load 0.004 [get_ports {core_block_id[1][5]}]
set_load -pin_load 0.004 [get_ports {core_block_id[1][4]}]
set_load -pin_load 0.004 [get_ports {core_block_id[1][3]}]
set_load -pin_load 0.004 [get_ports {core_block_id[1][2]}]
set_load -pin_load 0.004 [get_ports {core_block_id[1][1]}]
set_load -pin_load 0.004 [get_ports {core_block_id[1][0]}]
set_load -pin_load 0.004 [get_ports {core_block_id[0][7]}]
set_load -pin_load 0.004 [get_ports {core_block_id[0][6]}]
set_load -pin_load 0.004 [get_ports {core_block_id[0][5]}]
set_load -pin_load 0.004 [get_ports {core_block_id[0][4]}]
set_load -pin_load 0.004 [get_ports {core_block_id[0][3]}]
set_load -pin_load 0.004 [get_ports {core_block_id[0][2]}]
set_load -pin_load 0.004 [get_ports {core_block_id[0][1]}]
set_load -pin_load 0.004 [get_ports {core_block_id[0][0]}]
set_load -pin_load 0.004 [get_ports {core_thread_count[3][2]}]
set_load -pin_load 0.004 [get_ports {core_thread_count[3][1]}]
set_load -pin_load 0.004 [get_ports {core_thread_count[3][0]}]
set_load -pin_load 0.004 [get_ports {core_thread_count[2][2]}]
set_load -pin_load 0.004 [get_ports {core_thread_count[2][1]}]
set_load -pin_load 0.004 [get_ports {core_thread_count[2][0]}]
set_load -pin_load 0.004 [get_ports {core_thread_count[1][2]}]
set_load -pin_load 0.004 [get_ports {core_thread_count[1][1]}]
set_load -pin_load 0.004 [get_ports {core_thread_count[1][0]}]
set_load -pin_load 0.004 [get_ports {core_thread_count[0][2]}]
set_load -pin_load 0.004 [get_ports {core_thread_count[0][1]}]
set_load -pin_load 0.004 [get_ports {core_thread_count[0][0]}]
set_load -pin_load 0.004 [get_ports done]
set_switching_activity -period 1 -toggle_rate 0.00115967 -static_probability   \
0.995117 [get_pins {core_thread_count_reg[1][0]/QN}]
set_switching_activity -period 1 -toggle_rate 0.00115967 -static_probability   \
0.996735 [get_pins {core_thread_count_reg[1][1]/QN}]
set_switching_activity -period 1 -toggle_rate 0.00268555 -static_probability   \
0.0110168 [get_pins {core_thread_count_reg[1][2]/QN}]
set_switching_activity -period 1 -toggle_rate 0.00128174 -static_probability   \
0.996521 [get_pins {core_thread_count_reg[2][0]/QN}]
set_switching_activity -period 1 -toggle_rate 0.00112915 -static_probability   \
0.996307 [get_pins {core_thread_count_reg[2][1]/QN}]
set_switching_activity -period 1 -toggle_rate 0.0027771 -static_probability    \
0.0100403 [get_pins {core_thread_count_reg[2][2]/QN}]
set_switching_activity -period 1 -toggle_rate 0.164551 -static_probability     \
0.741089 [get_pins {core_start_reg[1]/QN}]
set_switching_activity -period 1 -toggle_rate 0.162537 -static_probability     \
0.735519 [get_pins {core_start_reg[2]/QN}]
set_switching_activity -period 1 -toggle_rate 0.0359192 -static_probability    \
0.913696 [get_pins {core_block_id_reg[0][1]/QN}]
set_switching_activity -period 1 -toggle_rate 0.017334 -static_probability     \
0.938583 [get_pins {core_block_id_reg[0][2]/QN}]
set_switching_activity -period 1 -toggle_rate 0.00509644 -static_probability   \
0.977707 [get_pins {core_block_id_reg[0][3]/QN}]
set_switching_activity -period 1 -toggle_rate 0.000610352 -static_probability  \
0.997284 [get_pins {core_block_id_reg[0][4]/QN}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {core_block_id_reg[0][5]/QN}]
set_switching_activity -period 1 -toggle_rate 0.0456238 -static_probability    \
0.893066 [get_pins {core_block_id_reg[0][0]/QN}]
set_switching_activity -period 1 -toggle_rate 0.0354004 -static_probability    \
0.912888 [get_pins {core_block_id_reg[1][1]/QN}]
set_switching_activity -period 1 -toggle_rate 0.0161438 -static_probability    \
0.941452 [get_pins {core_block_id_reg[1][2]/QN}]
set_switching_activity -period 1 -toggle_rate 0.00463867 -static_probability   \
0.980896 [get_pins {core_block_id_reg[1][3]/QN}]
set_switching_activity -period 1 -toggle_rate 0.000427246 -static_probability  \
0.997131 [get_pins {core_block_id_reg[1][4]/QN}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {core_block_id_reg[1][5]/QN}]
set_switching_activity -period 1 -toggle_rate 0.0327454 -static_probability    \
0.919205 [get_pins {core_block_id_reg[2][1]/QN}]
set_switching_activity -period 1 -toggle_rate 0.0159607 -static_probability    \
0.942062 [get_pins {core_block_id_reg[2][2]/QN}]
set_switching_activity -period 1 -toggle_rate 0.00506592 -static_probability   \
0.979248 [get_pins {core_block_id_reg[2][3]/QN}]
set_switching_activity -period 1 -toggle_rate 0.000793457 -static_probability  \
0.99588 [get_pins {core_block_id_reg[2][4]/QN}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {core_block_id_reg[2][5]/QN}]
set_switching_activity -period 1 -toggle_rate 0.0441284 -static_probability    \
0.886551 [get_pins {core_block_id_reg[1][0]/QN}]
set_switching_activity -period 1 -toggle_rate 0.0433044 -static_probability    \
0.890457 [get_pins {core_block_id_reg[2][0]/QN}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {blocks_dispatched_reg[6]/QN}]
set_switching_activity -period 1 -toggle_rate 0.0335999 -static_probability    \
0.918243 [get_pins {core_block_id_reg[3][1]/QN}]
set_switching_activity -period 1 -toggle_rate 0.0159302 -static_probability    \
0.940582 [get_pins {core_block_id_reg[3][2]/QN}]
set_switching_activity -period 1 -toggle_rate 0.00469971 -static_probability   \
0.98233 [get_pins {core_block_id_reg[3][3]/QN}]
set_switching_activity -period 1 -toggle_rate 0.000793457 -static_probability  \
0.996429 [get_pins {core_block_id_reg[3][4]/QN}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {core_block_id_reg[3][5]/QN}]
set_switching_activity -period 1 -toggle_rate 0.0456848 -static_probability    \
0.886353 [get_pins {core_block_id_reg[3][0]/QN}]
set_switching_activity -period 1 -toggle_rate 0.0780945 -static_probability    \
0.822098 [get_pins {blocks_dispatched_reg[1]/QN}]
set_switching_activity -period 1 -toggle_rate 0.0329895 -static_probability    \
0.888901 [get_pins {blocks_dispatched_reg[2]/QN}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {blocks_dispatched_reg[5]/QN}]
set_switching_activity -period 1 -toggle_rate 0.164429 -static_probability     \
0.786804 [get_pins {blocks_dispatched_reg[0]/QN}]
create_clock [get_ports clk]  -name clock  -period 1  -waveform {0 0.5}
group_path -name in2out  -from [list [get_ports clk] [get_ports reset]         \
[get_ports start] [get_ports {thread_count[7]}] [get_ports {thread_count[6]}]  \
[get_ports {thread_count[5]}] [get_ports {thread_count[4]}] [get_ports         \
{thread_count[3]}] [get_ports {thread_count[2]}] [get_ports {thread_count[1]}] \
[get_ports {thread_count[0]}] [get_ports {core_done[3]}] [get_ports            \
{core_done[2]}] [get_ports {core_done[1]}] [get_ports {core_done[0]}]]  -to    \
[list [get_ports {core_start[3]}] [get_ports {core_start[2]}] [get_ports       \
{core_start[1]}] [get_ports {core_start[0]}] [get_ports {core_reset[3]}]       \
[get_ports {core_reset[2]}] [get_ports {core_reset[1]}] [get_ports             \
{core_reset[0]}] [get_ports {core_block_id[3][7]}] [get_ports                  \
{core_block_id[3][6]}] [get_ports {core_block_id[3][5]}] [get_ports            \
{core_block_id[3][4]}] [get_ports {core_block_id[3][3]}] [get_ports            \
{core_block_id[3][2]}] [get_ports {core_block_id[3][1]}] [get_ports            \
{core_block_id[3][0]}] [get_ports {core_block_id[2][7]}] [get_ports            \
{core_block_id[2][6]}] [get_ports {core_block_id[2][5]}] [get_ports            \
{core_block_id[2][4]}] [get_ports {core_block_id[2][3]}] [get_ports            \
{core_block_id[2][2]}] [get_ports {core_block_id[2][1]}] [get_ports            \
{core_block_id[2][0]}] [get_ports {core_block_id[1][7]}] [get_ports            \
{core_block_id[1][6]}] [get_ports {core_block_id[1][5]}] [get_ports            \
{core_block_id[1][4]}] [get_ports {core_block_id[1][3]}] [get_ports            \
{core_block_id[1][2]}] [get_ports {core_block_id[1][1]}] [get_ports            \
{core_block_id[1][0]}] [get_ports {core_block_id[0][7]}] [get_ports            \
{core_block_id[0][6]}] [get_ports {core_block_id[0][5]}] [get_ports            \
{core_block_id[0][4]}] [get_ports {core_block_id[0][3]}] [get_ports            \
{core_block_id[0][2]}] [get_ports {core_block_id[0][1]}] [get_ports            \
{core_block_id[0][0]}] [get_ports {core_thread_count[3][2]}] [get_ports        \
{core_thread_count[3][1]}] [get_ports {core_thread_count[3][0]}] [get_ports    \
{core_thread_count[2][2]}] [get_ports {core_thread_count[2][1]}] [get_ports    \
{core_thread_count[2][0]}] [get_ports {core_thread_count[1][2]}] [get_ports    \
{core_thread_count[1][1]}] [get_ports {core_thread_count[1][0]}] [get_ports    \
{core_thread_count[0][2]}] [get_ports {core_thread_count[0][1]}] [get_ports    \
{core_thread_count[0][0]}] [get_ports done]]
group_path -name in2reg  -from [list [get_ports clk] [get_ports reset]         \
[get_ports start] [get_ports {thread_count[7]}] [get_ports {thread_count[6]}]  \
[get_ports {thread_count[5]}] [get_ports {thread_count[4]}] [get_ports         \
{thread_count[3]}] [get_ports {thread_count[2]}] [get_ports {thread_count[1]}] \
[get_ports {thread_count[0]}] [get_ports {core_done[3]}] [get_ports            \
{core_done[2]}] [get_ports {core_done[1]}] [get_ports {core_done[0]}]]  -to    \
[list [get_cells {core_reset_reg[0]}] [get_cells {core_reset_reg[1]}]          \
[get_cells {core_reset_reg[2]}] [get_cells {core_reset_reg[3]}] [get_cells     \
{core_start_reg[0]}] [get_cells {core_start_reg[1]}] [get_cells                \
{core_start_reg[2]}] [get_cells {core_start_reg[3]}] [get_cells                \
{core_thread_count_reg[0][0]}] [get_cells {core_thread_count_reg[0][1]}]       \
[get_cells {core_thread_count_reg[0][2]}] [get_cells                           \
{core_thread_count_reg[1][0]}] [get_cells {core_thread_count_reg[1][1]}]       \
[get_cells {core_thread_count_reg[1][2]}] [get_cells                           \
{core_thread_count_reg[2][0]}] [get_cells {core_thread_count_reg[2][1]}]       \
[get_cells {core_thread_count_reg[2][2]}] [get_cells                           \
{core_thread_count_reg[3][0]}] [get_cells {core_thread_count_reg[3][1]}]       \
[get_cells {core_thread_count_reg[3][2]}] [get_cells start_latch_reg]          \
[get_cells {blocks_done_reg[0]}] [get_cells {blocks_done_reg[1]}] [get_cells   \
{blocks_done_reg[2]}] [get_cells {blocks_done_reg[3]}] [get_cells              \
{blocks_done_reg[4]}] [get_cells {blocks_done_reg[5]}] [get_cells              \
{blocks_done_reg[6]}] [get_cells {blocks_done_reg[7]}] [get_cells              \
{blocks_dispatched_reg[0]}] [get_cells {blocks_dispatched_reg[1]}] [get_cells  \
{blocks_dispatched_reg[2]}] [get_cells {blocks_dispatched_reg[3]}] [get_cells  \
{blocks_dispatched_reg[4]}] [get_cells {blocks_dispatched_reg[5]}] [get_cells  \
{blocks_dispatched_reg[6]}] [get_cells done_reg] [get_cells                    \
{core_block_id_reg[0][0]}] [get_cells {core_block_id_reg[0][1]}] [get_cells    \
{core_block_id_reg[0][2]}] [get_cells {core_block_id_reg[0][3]}] [get_cells    \
{core_block_id_reg[0][4]}] [get_cells {core_block_id_reg[0][5]}] [get_cells    \
{core_block_id_reg[1][0]}] [get_cells {core_block_id_reg[1][1]}] [get_cells    \
{core_block_id_reg[1][2]}] [get_cells {core_block_id_reg[1][3]}] [get_cells    \
{core_block_id_reg[1][4]}] [get_cells {core_block_id_reg[1][5]}] [get_cells    \
{core_block_id_reg[2][0]}] [get_cells {core_block_id_reg[2][1]}] [get_cells    \
{core_block_id_reg[2][2]}] [get_cells {core_block_id_reg[2][3]}] [get_cells    \
{core_block_id_reg[2][4]}] [get_cells {core_block_id_reg[2][5]}] [get_cells    \
{core_block_id_reg[3][0]}] [get_cells {core_block_id_reg[3][1]}] [get_cells    \
{core_block_id_reg[3][2]}] [get_cells {core_block_id_reg[3][3]}] [get_cells    \
{core_block_id_reg[3][4]}] [get_cells {core_block_id_reg[3][5]}]]
group_path -name reg2out  -from [list [get_cells {core_reset_reg[0]}]          \
[get_cells {core_reset_reg[1]}] [get_cells {core_reset_reg[2]}] [get_cells     \
{core_reset_reg[3]}] [get_cells {core_start_reg[0]}] [get_cells                \
{core_start_reg[1]}] [get_cells {core_start_reg[2]}] [get_cells                \
{core_start_reg[3]}] [get_cells {core_thread_count_reg[0][0]}] [get_cells      \
{core_thread_count_reg[0][1]}] [get_cells {core_thread_count_reg[0][2]}]       \
[get_cells {core_thread_count_reg[1][0]}] [get_cells                           \
{core_thread_count_reg[1][1]}] [get_cells {core_thread_count_reg[1][2]}]       \
[get_cells {core_thread_count_reg[2][0]}] [get_cells                           \
{core_thread_count_reg[2][1]}] [get_cells {core_thread_count_reg[2][2]}]       \
[get_cells {core_thread_count_reg[3][0]}] [get_cells                           \
{core_thread_count_reg[3][1]}] [get_cells {core_thread_count_reg[3][2]}]       \
[get_cells start_latch_reg] [get_cells {blocks_done_reg[0]}] [get_cells        \
{blocks_done_reg[1]}] [get_cells {blocks_done_reg[2]}] [get_cells              \
{blocks_done_reg[3]}] [get_cells {blocks_done_reg[4]}] [get_cells              \
{blocks_done_reg[5]}] [get_cells {blocks_done_reg[6]}] [get_cells              \
{blocks_done_reg[7]}] [get_cells {blocks_dispatched_reg[0]}] [get_cells        \
{blocks_dispatched_reg[1]}] [get_cells {blocks_dispatched_reg[2]}] [get_cells  \
{blocks_dispatched_reg[3]}] [get_cells {blocks_dispatched_reg[4]}] [get_cells  \
{blocks_dispatched_reg[5]}] [get_cells {blocks_dispatched_reg[6]}] [get_cells  \
done_reg] [get_cells {core_block_id_reg[0][0]}] [get_cells                     \
{core_block_id_reg[0][1]}] [get_cells {core_block_id_reg[0][2]}] [get_cells    \
{core_block_id_reg[0][3]}] [get_cells {core_block_id_reg[0][4]}] [get_cells    \
{core_block_id_reg[0][5]}] [get_cells {core_block_id_reg[1][0]}] [get_cells    \
{core_block_id_reg[1][1]}] [get_cells {core_block_id_reg[1][2]}] [get_cells    \
{core_block_id_reg[1][3]}] [get_cells {core_block_id_reg[1][4]}] [get_cells    \
{core_block_id_reg[1][5]}] [get_cells {core_block_id_reg[2][0]}] [get_cells    \
{core_block_id_reg[2][1]}] [get_cells {core_block_id_reg[2][2]}] [get_cells    \
{core_block_id_reg[2][3]}] [get_cells {core_block_id_reg[2][4]}] [get_cells    \
{core_block_id_reg[2][5]}] [get_cells {core_block_id_reg[3][0]}] [get_cells    \
{core_block_id_reg[3][1]}] [get_cells {core_block_id_reg[3][2]}] [get_cells    \
{core_block_id_reg[3][3]}] [get_cells {core_block_id_reg[3][4]}] [get_cells    \
{core_block_id_reg[3][5]}]]  -to [list [get_ports {core_start[3]}] [get_ports  \
{core_start[2]}] [get_ports {core_start[1]}] [get_ports {core_start[0]}]       \
[get_ports {core_reset[3]}] [get_ports {core_reset[2]}] [get_ports             \
{core_reset[1]}] [get_ports {core_reset[0]}] [get_ports {core_block_id[3][7]}] \
[get_ports {core_block_id[3][6]}] [get_ports {core_block_id[3][5]}] [get_ports \
{core_block_id[3][4]}] [get_ports {core_block_id[3][3]}] [get_ports            \
{core_block_id[3][2]}] [get_ports {core_block_id[3][1]}] [get_ports            \
{core_block_id[3][0]}] [get_ports {core_block_id[2][7]}] [get_ports            \
{core_block_id[2][6]}] [get_ports {core_block_id[2][5]}] [get_ports            \
{core_block_id[2][4]}] [get_ports {core_block_id[2][3]}] [get_ports            \
{core_block_id[2][2]}] [get_ports {core_block_id[2][1]}] [get_ports            \
{core_block_id[2][0]}] [get_ports {core_block_id[1][7]}] [get_ports            \
{core_block_id[1][6]}] [get_ports {core_block_id[1][5]}] [get_ports            \
{core_block_id[1][4]}] [get_ports {core_block_id[1][3]}] [get_ports            \
{core_block_id[1][2]}] [get_ports {core_block_id[1][1]}] [get_ports            \
{core_block_id[1][0]}] [get_ports {core_block_id[0][7]}] [get_ports            \
{core_block_id[0][6]}] [get_ports {core_block_id[0][5]}] [get_ports            \
{core_block_id[0][4]}] [get_ports {core_block_id[0][3]}] [get_ports            \
{core_block_id[0][2]}] [get_ports {core_block_id[0][1]}] [get_ports            \
{core_block_id[0][0]}] [get_ports {core_thread_count[3][2]}] [get_ports        \
{core_thread_count[3][1]}] [get_ports {core_thread_count[3][0]}] [get_ports    \
{core_thread_count[2][2]}] [get_ports {core_thread_count[2][1]}] [get_ports    \
{core_thread_count[2][0]}] [get_ports {core_thread_count[1][2]}] [get_ports    \
{core_thread_count[1][1]}] [get_ports {core_thread_count[1][0]}] [get_ports    \
{core_thread_count[0][2]}] [get_ports {core_thread_count[0][1]}] [get_ports    \
{core_thread_count[0][0]}] [get_ports done]]
group_path -name reg2reg  -from [list [get_cells {core_reset_reg[0]}]          \
[get_cells {core_reset_reg[1]}] [get_cells {core_reset_reg[2]}] [get_cells     \
{core_reset_reg[3]}] [get_cells {core_start_reg[0]}] [get_cells                \
{core_start_reg[1]}] [get_cells {core_start_reg[2]}] [get_cells                \
{core_start_reg[3]}] [get_cells {core_thread_count_reg[0][0]}] [get_cells      \
{core_thread_count_reg[0][1]}] [get_cells {core_thread_count_reg[0][2]}]       \
[get_cells {core_thread_count_reg[1][0]}] [get_cells                           \
{core_thread_count_reg[1][1]}] [get_cells {core_thread_count_reg[1][2]}]       \
[get_cells {core_thread_count_reg[2][0]}] [get_cells                           \
{core_thread_count_reg[2][1]}] [get_cells {core_thread_count_reg[2][2]}]       \
[get_cells {core_thread_count_reg[3][0]}] [get_cells                           \
{core_thread_count_reg[3][1]}] [get_cells {core_thread_count_reg[3][2]}]       \
[get_cells start_latch_reg] [get_cells {blocks_done_reg[0]}] [get_cells        \
{blocks_done_reg[1]}] [get_cells {blocks_done_reg[2]}] [get_cells              \
{blocks_done_reg[3]}] [get_cells {blocks_done_reg[4]}] [get_cells              \
{blocks_done_reg[5]}] [get_cells {blocks_done_reg[6]}] [get_cells              \
{blocks_done_reg[7]}] [get_cells {blocks_dispatched_reg[0]}] [get_cells        \
{blocks_dispatched_reg[1]}] [get_cells {blocks_dispatched_reg[2]}] [get_cells  \
{blocks_dispatched_reg[3]}] [get_cells {blocks_dispatched_reg[4]}] [get_cells  \
{blocks_dispatched_reg[5]}] [get_cells {blocks_dispatched_reg[6]}] [get_cells  \
done_reg] [get_cells {core_block_id_reg[0][0]}] [get_cells                     \
{core_block_id_reg[0][1]}] [get_cells {core_block_id_reg[0][2]}] [get_cells    \
{core_block_id_reg[0][3]}] [get_cells {core_block_id_reg[0][4]}] [get_cells    \
{core_block_id_reg[0][5]}] [get_cells {core_block_id_reg[1][0]}] [get_cells    \
{core_block_id_reg[1][1]}] [get_cells {core_block_id_reg[1][2]}] [get_cells    \
{core_block_id_reg[1][3]}] [get_cells {core_block_id_reg[1][4]}] [get_cells    \
{core_block_id_reg[1][5]}] [get_cells {core_block_id_reg[2][0]}] [get_cells    \
{core_block_id_reg[2][1]}] [get_cells {core_block_id_reg[2][2]}] [get_cells    \
{core_block_id_reg[2][3]}] [get_cells {core_block_id_reg[2][4]}] [get_cells    \
{core_block_id_reg[2][5]}] [get_cells {core_block_id_reg[3][0]}] [get_cells    \
{core_block_id_reg[3][1]}] [get_cells {core_block_id_reg[3][2]}] [get_cells    \
{core_block_id_reg[3][3]}] [get_cells {core_block_id_reg[3][4]}] [get_cells    \
{core_block_id_reg[3][5]}]]  -to [list [get_cells {core_reset_reg[0]}]         \
[get_cells {core_reset_reg[1]}] [get_cells {core_reset_reg[2]}] [get_cells     \
{core_reset_reg[3]}] [get_cells {core_start_reg[0]}] [get_cells                \
{core_start_reg[1]}] [get_cells {core_start_reg[2]}] [get_cells                \
{core_start_reg[3]}] [get_cells {core_thread_count_reg[0][0]}] [get_cells      \
{core_thread_count_reg[0][1]}] [get_cells {core_thread_count_reg[0][2]}]       \
[get_cells {core_thread_count_reg[1][0]}] [get_cells                           \
{core_thread_count_reg[1][1]}] [get_cells {core_thread_count_reg[1][2]}]       \
[get_cells {core_thread_count_reg[2][0]}] [get_cells                           \
{core_thread_count_reg[2][1]}] [get_cells {core_thread_count_reg[2][2]}]       \
[get_cells {core_thread_count_reg[3][0]}] [get_cells                           \
{core_thread_count_reg[3][1]}] [get_cells {core_thread_count_reg[3][2]}]       \
[get_cells start_latch_reg] [get_cells {blocks_done_reg[0]}] [get_cells        \
{blocks_done_reg[1]}] [get_cells {blocks_done_reg[2]}] [get_cells              \
{blocks_done_reg[3]}] [get_cells {blocks_done_reg[4]}] [get_cells              \
{blocks_done_reg[5]}] [get_cells {blocks_done_reg[6]}] [get_cells              \
{blocks_done_reg[7]}] [get_cells {blocks_dispatched_reg[0]}] [get_cells        \
{blocks_dispatched_reg[1]}] [get_cells {blocks_dispatched_reg[2]}] [get_cells  \
{blocks_dispatched_reg[3]}] [get_cells {blocks_dispatched_reg[4]}] [get_cells  \
{blocks_dispatched_reg[5]}] [get_cells {blocks_dispatched_reg[6]}] [get_cells  \
done_reg] [get_cells {core_block_id_reg[0][0]}] [get_cells                     \
{core_block_id_reg[0][1]}] [get_cells {core_block_id_reg[0][2]}] [get_cells    \
{core_block_id_reg[0][3]}] [get_cells {core_block_id_reg[0][4]}] [get_cells    \
{core_block_id_reg[0][5]}] [get_cells {core_block_id_reg[1][0]}] [get_cells    \
{core_block_id_reg[1][1]}] [get_cells {core_block_id_reg[1][2]}] [get_cells    \
{core_block_id_reg[1][3]}] [get_cells {core_block_id_reg[1][4]}] [get_cells    \
{core_block_id_reg[1][5]}] [get_cells {core_block_id_reg[2][0]}] [get_cells    \
{core_block_id_reg[2][1]}] [get_cells {core_block_id_reg[2][2]}] [get_cells    \
{core_block_id_reg[2][3]}] [get_cells {core_block_id_reg[2][4]}] [get_cells    \
{core_block_id_reg[2][5]}] [get_cells {core_block_id_reg[3][0]}] [get_cells    \
{core_block_id_reg[3][1]}] [get_cells {core_block_id_reg[3][2]}] [get_cells    \
{core_block_id_reg[3][3]}] [get_cells {core_block_id_reg[3][4]}] [get_cells    \
{core_block_id_reg[3][5]}]]
set_input_delay -clock clock  0.75  [get_ports clk]
set_input_delay -clock clock  0.75  [get_ports reset]
set_input_delay -clock clock  0.75  [get_ports start]
set_input_delay -clock clock  0.75  [get_ports {thread_count[7]}]
set_input_delay -clock clock  0.75  [get_ports {thread_count[6]}]
set_input_delay -clock clock  0.75  [get_ports {thread_count[5]}]
set_input_delay -clock clock  0.75  [get_ports {thread_count[4]}]
set_input_delay -clock clock  0.75  [get_ports {thread_count[3]}]
set_input_delay -clock clock  0.75  [get_ports {thread_count[2]}]
set_input_delay -clock clock  0.75  [get_ports {thread_count[1]}]
set_input_delay -clock clock  0.75  [get_ports {thread_count[0]}]
set_input_delay -clock clock  0.75  [get_ports {core_done[3]}]
set_input_delay -clock clock  0.75  [get_ports {core_done[2]}]
set_input_delay -clock clock  0.75  [get_ports {core_done[1]}]
set_input_delay -clock clock  0.75  [get_ports {core_done[0]}]
set_output_delay -clock clock  0.75  [get_ports {core_start[3]}]
set_output_delay -clock clock  0.75  [get_ports {core_start[2]}]
set_output_delay -clock clock  0.75  [get_ports {core_start[1]}]
set_output_delay -clock clock  0.75  [get_ports {core_start[0]}]
set_output_delay -clock clock  0.75  [get_ports {core_reset[3]}]
set_output_delay -clock clock  0.75  [get_ports {core_reset[2]}]
set_output_delay -clock clock  0.75  [get_ports {core_reset[1]}]
set_output_delay -clock clock  0.75  [get_ports {core_reset[0]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[3][7]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[3][6]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[3][5]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[3][4]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[3][3]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[3][2]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[3][1]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[3][0]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[2][7]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[2][6]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[2][5]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[2][4]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[2][3]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[2][2]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[2][1]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[2][0]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[1][7]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[1][6]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[1][5]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[1][4]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[1][3]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[1][2]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[1][1]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[1][0]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[0][7]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[0][6]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[0][5]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[0][4]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[0][3]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[0][2]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[0][1]}]
set_output_delay -clock clock  0.75  [get_ports {core_block_id[0][0]}]
set_output_delay -clock clock  0.75  [get_ports {core_thread_count[3][2]}]
set_output_delay -clock clock  0.75  [get_ports {core_thread_count[3][1]}]
set_output_delay -clock clock  0.75  [get_ports {core_thread_count[3][0]}]
set_output_delay -clock clock  0.75  [get_ports {core_thread_count[2][2]}]
set_output_delay -clock clock  0.75  [get_ports {core_thread_count[2][1]}]
set_output_delay -clock clock  0.75  [get_ports {core_thread_count[2][0]}]
set_output_delay -clock clock  0.75  [get_ports {core_thread_count[1][2]}]
set_output_delay -clock clock  0.75  [get_ports {core_thread_count[1][1]}]
set_output_delay -clock clock  0.75  [get_ports {core_thread_count[1][0]}]
set_output_delay -clock clock  0.75  [get_ports {core_thread_count[0][2]}]
set_output_delay -clock clock  0.75  [get_ports {core_thread_count[0][1]}]
set_output_delay -clock clock  0.75  [get_ports {core_thread_count[0][0]}]
set_output_delay -clock clock  0.75  [get_ports done]
set_voltage 0.720000 -min 0.720000  -object_list VDD
set_voltage 0.000000 -min 0.000000  -object_list VSS
set compile_inbound_cell_optimization false
set compile_inbound_max_cell_percentage 10.0
