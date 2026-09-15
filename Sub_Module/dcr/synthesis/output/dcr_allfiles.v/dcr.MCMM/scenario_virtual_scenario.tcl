if { [namespace current] != {::6A4B40C0} } { error {This script [file tail [info script]] should not be sourced directly}; }
###################################################################

# Created by write_script -format dctcl for scenario constraints on Mon Jul  6 \
11:14:32 2026

###################################################################

# Set the current_design #
current_design dcr


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
set_load -pin_load 0.004 [get_ports {thread_count[7]}]
set_load -pin_load 0.004 [get_ports {thread_count[6]}]
set_load -pin_load 0.004 [get_ports {thread_count[5]}]
set_load -pin_load 0.004 [get_ports {thread_count[4]}]
set_load -pin_load 0.004 [get_ports {thread_count[3]}]
set_load -pin_load 0.004 [get_ports {thread_count[2]}]
set_load -pin_load 0.004 [get_ports {thread_count[1]}]
set_load -pin_load 0.004 [get_ports {thread_count[0]}]
set_switching_activity -period 1 -toggle_rate 0.0575562 -static_probability    \
0.823105 [get_pins {dcr_reg_reg[0]/QN}]
set_switching_activity -period 1 -toggle_rate 0.058136 -static_probability     \
0.826401 [get_pins {dcr_reg_reg[1]/QN}]
set_switching_activity -period 1 -toggle_rate 0.0563965 -static_probability    \
0.819138 [get_pins {dcr_reg_reg[2]/QN}]
set_switching_activity -period 1 -toggle_rate 0.0597839 -static_probability    \
0.815323 [get_pins {dcr_reg_reg[3]/QN}]
set_switching_activity -period 1 -toggle_rate 0.0593262 -static_probability    \
0.814194 [get_pins {dcr_reg_reg[4]/QN}]
set_switching_activity -period 1 -toggle_rate 0.0619202 -static_probability    \
0.818008 [get_pins {dcr_reg_reg[5]/QN}]
set_switching_activity -period 1 -toggle_rate 0.0577698 -static_probability    \
0.813156 [get_pins {dcr_reg_reg[6]/QN}]
set_switching_activity -period 1 -toggle_rate 0.0592957 -static_probability    \
0.813263 [get_pins {dcr_reg_reg[7]/QN}]
create_clock [get_ports clk]  -name clock  -period 1  -waveform {0 0.5}
group_path -name in2out  -from [list [get_ports clk] [get_ports reset]         \
[get_ports device_control_write_enable] [get_ports {device_control_data[7]}]   \
[get_ports {device_control_data[6]}] [get_ports {device_control_data[5]}]      \
[get_ports {device_control_data[4]}] [get_ports {device_control_data[3]}]      \
[get_ports {device_control_data[2]}] [get_ports {device_control_data[1]}]      \
[get_ports {device_control_data[0]}]]  -to [list [get_ports {thread_count[7]}] \
[get_ports {thread_count[6]}] [get_ports {thread_count[5]}] [get_ports         \
{thread_count[4]}] [get_ports {thread_count[3]}] [get_ports {thread_count[2]}] \
[get_ports {thread_count[1]}] [get_ports {thread_count[0]}]]
group_path -name in2reg  -from [list [get_ports clk] [get_ports reset]         \
[get_ports device_control_write_enable] [get_ports {device_control_data[7]}]   \
[get_ports {device_control_data[6]}] [get_ports {device_control_data[5]}]      \
[get_ports {device_control_data[4]}] [get_ports {device_control_data[3]}]      \
[get_ports {device_control_data[2]}] [get_ports {device_control_data[1]}]      \
[get_ports {device_control_data[0]}]]  -to [list [get_cells {dcr_reg_reg[0]}]  \
[get_cells {dcr_reg_reg[1]}] [get_cells {dcr_reg_reg[2]}] [get_cells           \
{dcr_reg_reg[3]}] [get_cells {dcr_reg_reg[4]}] [get_cells {dcr_reg_reg[5]}]    \
[get_cells {dcr_reg_reg[6]}] [get_cells {dcr_reg_reg[7]}]]
group_path -name reg2out  -from [list [get_cells {dcr_reg_reg[0]}] [get_cells  \
{dcr_reg_reg[1]}] [get_cells {dcr_reg_reg[2]}] [get_cells {dcr_reg_reg[3]}]    \
[get_cells {dcr_reg_reg[4]}] [get_cells {dcr_reg_reg[5]}] [get_cells           \
{dcr_reg_reg[6]}] [get_cells {dcr_reg_reg[7]}]]  -to [list [get_ports          \
{thread_count[7]}] [get_ports {thread_count[6]}] [get_ports {thread_count[5]}] \
[get_ports {thread_count[4]}] [get_ports {thread_count[3]}] [get_ports         \
{thread_count[2]}] [get_ports {thread_count[1]}] [get_ports                    \
{thread_count[0]}]]
group_path -name reg2reg  -from [list [get_cells {dcr_reg_reg[0]}] [get_cells  \
{dcr_reg_reg[1]}] [get_cells {dcr_reg_reg[2]}] [get_cells {dcr_reg_reg[3]}]    \
[get_cells {dcr_reg_reg[4]}] [get_cells {dcr_reg_reg[5]}] [get_cells           \
{dcr_reg_reg[6]}] [get_cells {dcr_reg_reg[7]}]]  -to [list [get_cells          \
{dcr_reg_reg[0]}] [get_cells {dcr_reg_reg[1]}] [get_cells {dcr_reg_reg[2]}]    \
[get_cells {dcr_reg_reg[3]}] [get_cells {dcr_reg_reg[4]}] [get_cells           \
{dcr_reg_reg[5]}] [get_cells {dcr_reg_reg[6]}] [get_cells {dcr_reg_reg[7]}]]
set_input_delay -clock clock  0.75  [get_ports clk]
set_input_delay -clock clock  0.75  [get_ports reset]
set_input_delay -clock clock  0.75  [get_ports device_control_write_enable]
set_input_delay -clock clock  0.75  [get_ports {device_control_data[7]}]
set_input_delay -clock clock  0.75  [get_ports {device_control_data[6]}]
set_input_delay -clock clock  0.75  [get_ports {device_control_data[5]}]
set_input_delay -clock clock  0.75  [get_ports {device_control_data[4]}]
set_input_delay -clock clock  0.75  [get_ports {device_control_data[3]}]
set_input_delay -clock clock  0.75  [get_ports {device_control_data[2]}]
set_input_delay -clock clock  0.75  [get_ports {device_control_data[1]}]
set_input_delay -clock clock  0.75  [get_ports {device_control_data[0]}]
set_output_delay -clock clock  0.75  [get_ports {thread_count[7]}]
set_output_delay -clock clock  0.75  [get_ports {thread_count[6]}]
set_output_delay -clock clock  0.75  [get_ports {thread_count[5]}]
set_output_delay -clock clock  0.75  [get_ports {thread_count[4]}]
set_output_delay -clock clock  0.75  [get_ports {thread_count[3]}]
set_output_delay -clock clock  0.75  [get_ports {thread_count[2]}]
set_output_delay -clock clock  0.75  [get_ports {thread_count[1]}]
set_output_delay -clock clock  0.75  [get_ports {thread_count[0]}]
set_voltage 0.720000 -min 0.720000  -object_list VDD
set_voltage 0.000000 -min 0.000000  -object_list VSS
set compile_inbound_cell_optimization false
set compile_inbound_max_cell_percentage 10.0
