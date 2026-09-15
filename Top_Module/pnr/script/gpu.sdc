create_clock -period 1 -name clock [get_ports clk]

set_input_delay 0.75 -clock clk [get_ports [all_inputs]]
set_output_delay 0.75 -clock clk  [get_ports [all_outputs]]

set_input_delay 0.75 -clock e_clk [get_ports [all_inputs]]
set_output_delay 0.75 -clock e_clk  [get_ports [all_outputs]]

set_load 0.004  [get_ports [all_outputs]]
set_max_fanout 200 [current_design]
set_max_transition 0.1 [current_design]
set_max_capacitance 102 [current_design]