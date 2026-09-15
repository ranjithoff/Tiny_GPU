remove_corners -all
remove_modes -all
remove_scenarios -all

set corner default 
set_process_number 0.5 -corner default

set_temperature 25 -corners default
set_voltage 0.72  -object_list VDD -corners default
set_voltage 0.00  -object_list VSS -corners default

current_mode 
current_corner

create_scenario -name dcr -mode default -corner default
report_scenarios
set_scenario_status dcr -active true -setup true -hold true -max_transition true \
 -max_capacitance true -min_capacitance true -leakage_power true -dynamic_power true