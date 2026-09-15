###################################################################

# Created by write_sdc on Mon Jul  6 11:14:32 2026

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
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
create_clock [get_ports clk]  -name clock  -period 1  -waveform {0 0.5}
group_path -name in2out  -from [list [get_ports clk] [get_ports reset] [get_ports                      \
device_control_write_enable] [get_ports {device_control_data[7]}] [get_ports   \
{device_control_data[6]}] [get_ports {device_control_data[5]}] [get_ports      \
{device_control_data[4]}] [get_ports {device_control_data[3]}] [get_ports      \
{device_control_data[2]}] [get_ports {device_control_data[1]}] [get_ports      \
{device_control_data[0]}]]  -to [list [get_ports {thread_count[7]}] [get_ports {thread_count[6]}]         \
[get_ports {thread_count[5]}] [get_ports {thread_count[4]}] [get_ports         \
{thread_count[3]}] [get_ports {thread_count[2]}] [get_ports {thread_count[1]}] \
[get_ports {thread_count[0]}]]
group_path -name in2reg  -from [list [get_ports clk] [get_ports reset] [get_ports                      \
device_control_write_enable] [get_ports {device_control_data[7]}] [get_ports   \
{device_control_data[6]}] [get_ports {device_control_data[5]}] [get_ports      \
{device_control_data[4]}] [get_ports {device_control_data[3]}] [get_ports      \
{device_control_data[2]}] [get_ports {device_control_data[1]}] [get_ports      \
{device_control_data[0]}]]  -to [list [get_cells {dcr_reg_reg[0]}] [get_cells {dcr_reg_reg[1]}]           \
[get_cells {dcr_reg_reg[2]}] [get_cells {dcr_reg_reg[3]}] [get_cells           \
{dcr_reg_reg[4]}] [get_cells {dcr_reg_reg[5]}] [get_cells {dcr_reg_reg[6]}]    \
[get_cells {dcr_reg_reg[7]}]]
group_path -name reg2out  -from [list [get_cells {dcr_reg_reg[0]}] [get_cells {dcr_reg_reg[1]}]         \
[get_cells {dcr_reg_reg[2]}] [get_cells {dcr_reg_reg[3]}] [get_cells           \
{dcr_reg_reg[4]}] [get_cells {dcr_reg_reg[5]}] [get_cells {dcr_reg_reg[6]}]    \
[get_cells {dcr_reg_reg[7]}]]  -to [list [get_ports {thread_count[7]}] [get_ports {thread_count[6]}]         \
[get_ports {thread_count[5]}] [get_ports {thread_count[4]}] [get_ports         \
{thread_count[3]}] [get_ports {thread_count[2]}] [get_ports {thread_count[1]}] \
[get_ports {thread_count[0]}]]
group_path -name reg2reg  -from [list [get_cells {dcr_reg_reg[0]}] [get_cells {dcr_reg_reg[1]}]         \
[get_cells {dcr_reg_reg[2]}] [get_cells {dcr_reg_reg[3]}] [get_cells           \
{dcr_reg_reg[4]}] [get_cells {dcr_reg_reg[5]}] [get_cells {dcr_reg_reg[6]}]    \
[get_cells {dcr_reg_reg[7]}]]  -to [list [get_cells {dcr_reg_reg[0]}] [get_cells {dcr_reg_reg[1]}]           \
[get_cells {dcr_reg_reg[2]}] [get_cells {dcr_reg_reg[3]}] [get_cells           \
{dcr_reg_reg[4]}] [get_cells {dcr_reg_reg[5]}] [get_cells {dcr_reg_reg[6]}]    \
[get_cells {dcr_reg_reg[7]}]]
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
set_voltage 0.72  -min 0.72  -object_list VDD
set_voltage 0  -min 0  -object_list VSS
set_load 0  [get_nets clk]
set_resistance 0  [get_nets clk]
set_load -max 0.0001342  [get_nets reset]
set_load -min 0.000121612  [get_nets reset]
set_resistance 0.00341544  [get_nets reset]
set_load -max 9.06843e-05  [get_nets device_control_write_enable]
set_load -min 8.21618e-05  [get_nets device_control_write_enable]
set_resistance 0.00235743  [get_nets device_control_write_enable]
set_load -max 8.98776e-05  [get_nets {device_control_data[7]}]
set_load -min 8.13496e-05  [get_nets {device_control_data[7]}]
set_resistance 0.00258774  [get_nets {device_control_data[7]}]
set_load -max 0.00013906  [get_nets {device_control_data[6]}]
set_load -min 0.000126097  [get_nets {device_control_data[6]}]
set_resistance 0.00328825  [get_nets {device_control_data[6]}]
set_load -max 0.000118642  [get_nets {device_control_data[5]}]
set_load -min 0.000107351  [get_nets {device_control_data[5]}]
set_resistance 0.00351846  [get_nets {device_control_data[5]}]
set_load -max 8.06495e-05  [get_nets {device_control_data[4]}]
set_load -min 7.30052e-05  [get_nets {device_control_data[4]}]
set_resistance 0.0022972  [get_nets {device_control_data[4]}]
set_load -max 0.000156462  [get_nets {device_control_data[3]}]
set_load -min 0.000141466  [get_nets {device_control_data[3]}]
set_resistance 0.00496964  [get_nets {device_control_data[3]}]
set_load -max 0.000146097  [get_nets {device_control_data[2]}]
set_load -min 0.000132383  [get_nets {device_control_data[2]}]
set_resistance 0.00374822  [get_nets {device_control_data[2]}]
set_load -max 0.000149799  [get_nets {device_control_data[1]}]
set_load -min 0.000135764  [get_nets {device_control_data[1]}]
set_resistance 0.0037622  [get_nets {device_control_data[1]}]
set_load -max 8.01889e-05  [get_nets {device_control_data[0]}]
set_load -min 7.26533e-05  [get_nets {device_control_data[0]}]
set_resistance 0.00208291  [get_nets {device_control_data[0]}]
set_load -max 0.00071317  [get_nets {thread_count[7]}]
set_load -min 0.000645785  [get_nets {thread_count[7]}]
set_resistance 0.0196564  [get_nets {thread_count[7]}]
set_load -max 0.000237392  [get_nets {thread_count[6]}]
set_load -min 0.000215133  [get_nets {thread_count[6]}]
set_resistance 0.00601461  [get_nets {thread_count[6]}]
set_load -max 0.000373767  [get_nets {thread_count[5]}]
set_load -min 0.000338401  [get_nets {thread_count[5]}]
set_resistance 0.0104577  [get_nets {thread_count[5]}]
set_load -max 0.00022152  [get_nets {thread_count[4]}]
set_load -min 0.000200758  [get_nets {thread_count[4]}]
set_resistance 0.00558279  [get_nets {thread_count[4]}]
set_load -max 0.000217746  [get_nets {thread_count[3]}]
set_load -min 0.00019743  [get_nets {thread_count[3]}]
set_resistance 0.00520231  [get_nets {thread_count[3]}]
set_load -max 0.000384503  [get_nets {thread_count[2]}]
set_load -min 0.000348156  [get_nets {thread_count[2]}]
set_resistance 0.0106492  [get_nets {thread_count[2]}]
set_load -max 0.000324629  [get_nets {thread_count[1]}]
set_load -min 0.000293941  [get_nets {thread_count[1]}]
set_resistance 0.00899599  [get_nets {thread_count[1]}]
set_load -max 0.00021641  [get_nets {thread_count[0]}]
set_load -min 0.000195926  [get_nets {thread_count[0]}]
set_resistance 0.00607734  [get_nets {thread_count[0]}]
set_load -max 0.000194431  [get_nets n1]
set_load -min 0.000175957  [get_nets n1]
set_resistance 0.00567566  [get_nets n1]
set_load -max 2.98289e-05  [get_nets n2]
set_load -min 2.69911e-05  [get_nets n2]
set_resistance 0.000882011  [get_nets n2]
set_load -max 0.00018767  [get_nets n3]
set_load -min 0.000169779  [get_nets n3]
set_resistance 0.00566186  [get_nets n3]
set_load -max 1.57128e-05  [get_nets n4]
set_load -min 1.42361e-05  [get_nets n4]
set_resistance 0.000408437  [get_nets n4]
set_load -max 2.43391e-05  [get_nets n5]
set_load -min 2.20673e-05  [get_nets n5]
set_resistance 0.000584344  [get_nets n5]
set_load -max 0.000227788  [get_nets n6]
set_load -min 0.000205974  [get_nets n6]
set_resistance 0.0071792  [get_nets n6]
set_load -max 5.63543e-05  [get_nets n7]
set_load -min 5.09801e-05  [get_nets n7]
set_resistance 0.00170631  [get_nets n7]
set_load -max 0.000517379  [get_nets n8]
set_load -min 0.00046835  [get_nets n8]
set_resistance 0.0147023  [get_nets n8]
set_load -max 0.000648706  [get_nets n11]
set_load -min 0.000587392  [get_nets n11]
set_resistance 0.0128232  [get_nets n11]
set_load -max 0.000644574  [get_nets n12]
set_load -min 0.000583657  [get_nets n12]
set_resistance 0.012729  [get_nets n12]
