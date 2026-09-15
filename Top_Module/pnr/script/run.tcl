##############################################################################################################
# Tiny GPU Project : TOP MODULE
# Script: run.tcl
##############################################################################################################

set_host_options -max_cores 16

set TECH_FILE           "/home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_TECH_DATA/tf/saed14nm_1p9m.tf" 

set REFERENCE_LIBRARY   "[glob /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_LVT/ndm/*.ndm] \ 
                         [glob /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_RVT/ndm/*.ndm] \
                         ../../../submodule/dcr/lm/output/dcr.ndm\
                         ../../../submodule/dispatch/lm/output/dispatch.ndm"

##############################################################################################################
## Creating Library 
##############################################################################################################

create_lib -technology $TECH_FILE -ref_libs $REFERENCE_LIBRARY gpu.dlib
read_verilog ../../synthesis/output/gpu_Netlist.v
current_design

##############################################################################################################
## RC parasitics, placement site and routing layer setup
##############################################################################################################

read_parasitic_tech -layermap /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_TECH_DATA/map/saed14nm_tf_itf_tluplus.map\
-tlup /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_TECH_DATA/tlup/saed14nm_1p9m_Cmax.tlup -name maxTLU

read_parasitic_tech -layermap /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_TECH_DATA/map/saed14nm_tf_itf_tluplus.map\
-tlup /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_TECH_DATA/tlup/saed14nm_1p9m_Cmin.tlup -name minTLU

set_parasitic_parameters -late_spec maxTLU -early_spec minTLU

report_lib -parasitic_tech gpu.dlib
set_attribute [get_layers {M1 M3 M5 M7 M9}] routing_direction horizontal
set_attribute [get_layers {M2 M4 M6 M8}] routing_direction vertical
report_ignored_layers
set_ignored_layers -max_routing_layer M9
report_ignored_layers

###############################################################################################################
## Constraint Files
###############################################################################################################

reset_upf
set_app_options -list {mv.incomplete_upf.enable {true}}

load_upf ../script/gpu.upf
commit_upf
report_incomplete_upf

set_voltage 0.585 -object_list VDDH
set_voltage 0.72 -object_list VDD
set_voltage 0.00 -object_list VSS

check_mv_design
 
get_ports *clk*
create_clock -period 1 -name func_clock [get_ports clk]
report_clock

source -echo ../script/mcmm.tcl 
report_modes
report_scenarios
report_pvt

save_block -as gpu/1_initial_design_done

###############################################################################################################
## Sanity Checks
###############################################################################################################

check_netlist
check_design -checks mv_design

##############################################################################################################
## Initilise floor plan,Power Planning,Place Pins and Physical Only Cells
##############################################################################################################

initialize_floorplan -shape U -side_length {180 90 90 90 90 90} -core_offset {10} -core_utilization 0.6
shape_blocks

###############################################
# Place Pins 
###############################################

set_block_pin_constraints -self -allowed_layers {M3 M5} -sides {1 3 5 7}
place_pins -ports [get_ports -filter "direction ==in"]
set_block_pin_constraints -self -allowed_layers {M2 M4} -sides {2 4 6 8}
place_pins -ports [get_ports -filter "direction ==out"]

set_attribute [get_ports *] physical_status fixed

###############################################
# Create Keepout Margin And Guard Band Setup
###############################################

set_attribute -objects [get_voltage_area_shapes VOLTAGE_AREA_SHAPE_1] -name guard_band -value {2.664 2.4}

create_keepout_margin -type hard -outer {5 5 5 5} [get_cells dcr_instance]
create_keepout_margin -type hard -outer {5 5 5 5} [get_cells dispatch_instance]

save_block -as gpu/2_Floorplan_done

###############################################
# Power Planning
###############################################

source -echo ../script/gpu_pns.tcl

check_pg_connectivity
check_pg_drc
check_pg_missing_vias

save_block -as gpu/3_power_network_synthesis_done

###############################################
# Boundary Cells Insertion
###############################################

get_lib_cells *CAP*

create_boundary_cells  \
-left_boundary_cell saed14lvt_base_frame_timing/SAEDLVT14_CAPTTAPP6 -right_boundary_cell saed14lvt_base_frame_timing/SAEDLVT14_CAPTTAPP6 \
 -top_boundary_cells saed14lvt_base_frame_timing/SAEDLVT14_CAPTTAPP6 -bottom_boundary_cells saed14lvt_base_frame_timing/SAEDLVT14_CAPTTAPP6

connect_pg_net

check_legality

# remove_cells *CAP* -force

save_block -as gpu/4_Boundary_cells_insertion_done

##############################################################################################################
## Placement 
##############################################################################################################

check_design -checks pre_placement_stage

create_placement -congestion -timing_driven
legalize_placement

set_app_options -name place.coarse.max_density -value 0.4

create_clock -period 1 -name func_clock [get_ports clk]

place_opt
legalize_placement

check_legality

report_design
report_congestion
report_timing
report_timing -delay_type min

set_app_options -list {shell.common.report_default_significant_digits {5}}

save_block -as gpu/5_placement_done

##############################################################################################################
## Clock Tree Synthesis 
##############################################################################################################

clock_opt
report_design
report_timing
report_timing -delay_type min
report_power
report_qor -summary

save_block -as gpu/6_cts_done

##############################################################################################################
## Routing
##############################################################################################################

check_design -checks pre_route_stage

route_auto
route_opt
route_eco

check_routes
check_lvs

check_legality
report_design
report_timing
report_timing -delay_type min


report_constraint
report_constraints -all_violators

save_block -as gpu/6_routing_done

####################################################
# Insert Filler Cells in the Design
####################################################

get_lib_cells *FIL*
set filler [get_lib_cells *FIL*]
create_stdcell_fillers -lib_cells $filler

connect_pg_net

check_legality

# remove_cells *FIL* -force

save_block -as dcr/8_filler_cells_done

##############################################################################################################
## Analysis Design Report
##############################################################################################################

report_design > ../report/design.rpt
report_timing > ../report/setup_timing.rpt
report_timing -delay_type min > ../report/hold_timing.rpt
report_power > ../report/power.rpt
report_qor -summary > ../report/qor.rpt

save_block -as gpu/7_report_generation_done

####################################################
# Convert Netlist to GDSII
####################################################

write_gds ../output/gpu.gds

save_block -as gpu/8_file_generator_done

save_lib