remove_scenarios -all
remove_modes -all
remove_corners -all

##################################################################
# MODES
##################################################################

create_mode func
create_mode test

##################################################################
# CLOCKS
##################################################################

current_mode func
create_clock -period 1 -name func_clock [get_ports clk]

current_mode test
create_clock -period 5 -name test_clock [get_ports clk]

##################################################################
# CORNERS
##################################################################

create_corner ss0p585v25c

##################################################################
# PVT
##################################################################

current_corner ss0p585v25c
set_parasitic_parameters -early_spec maxTLU -late_spec maxTLU -corners ss0p585v25c
set_temperature 25 -corners ss0p585v25c
set_process_number 0.5 -corners ss0p585v25c
set_process_label slow -corners ss0p585v25c

set_voltage 0.585  -object_list VDDH -corners ss0p585v25c
set_voltage 0.72   -object_list VDD  -corners ss0p585v25c
set_voltage 0.00  -object_list VSS -corners ss0p585v25c

set_timing_derate -early 0.93 -cell_delay -net_delay
set_load 20 [all_outputs]

##################################################################
# SCENARIO
##################################################################

create_scenario -name func.ss0p585v25c -mode func -corner ss0p585v25c
create_scenario -name test.ss0p585v25c -mode test -corner ss0p585v25c

current_scenario func.ss0p585v25c
set_clock_uncertainty -setup 0.3 [get_clocks func_clock]
set_clock_latency 0.6 [get_clocks func_clock]
set_clock_transition 0.2 [get_clocks func_clock]

current_scenario test.ss0p585v25c
set_clock_uncertainty -setup 0.3 [get_clocks test_clock]
set_clock_latency 0.6 [get_clocks test_clock]
set_clock_transition 0.2 [get_clocks test_clock]

##################################################################
# SET ONE DEFAULT SCENARIO
##################################################################

current_scenario func.ss0p585v25c
current_scenario