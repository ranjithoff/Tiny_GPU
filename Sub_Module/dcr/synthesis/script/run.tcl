###############################################################################################################
# Tiny GPU Project : DCR
# Script: run.tcl
###############################################################################################################

set_host_options -max_cores 16

set TECH_FILE           /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_TECH_DATA/tf/saed14nm_1p9m.tf   
set synthetic_library    dw_foundation.sldb 
set REFERENCE_LIBRARY  " [glob /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_LVT/ndm/*.ndm] \
	               [glob /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_RVT/ndm/*.ndm] "


################################################################################################################
## Set Library
################################################################################################################
           
set target_library  " [glob /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_LVT/liberty/nldm/*/saed14lvt_*_ss0p72v25c.db] \
	            [glob /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_RVT/liberty/nldm/*/saed14rvt_*_ss0p72v25c.db] " 

set link_library   " [glob /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_LVT/liberty/nldm/*/saed14lvt_*_ss0p72v25c.db] \
	           [glob /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_RVT/liberty/nldm/*/saed14rvt_*_ss0p72v25c.db] \
                     $synthetic_library "

################################################################################################################
## RC parasitics, placement site and routing layer setup
################################################################################################################

set_tlu_plus_files -tech2itf_map /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_TECH_DATA/map/saed14nm_tf_itf_tluplus.map \
-max_tluplus /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_TECH_DATA/tlup/saed14nm_1p9m_Cmax.tlup  \
-min_tluplus /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_TECH_DATA/tlup/saed14nm_1p9m_Cmin.tlup 

################################################################################################################
## Creating Library
################################################################################################################

create_lib -technology $TECH_FILE -ref_libs $REFERENCE_LIBRARY dcr.dlib 
		
################################################################################################################
## Read/Convert to WV GEtech/Connet Sub block to TOP block
################################################################################################################

analyze -format verilog ../../../../rtl/dcr.v
elaborate dcr
link
current_design

################################################################################################################
## Constraint Files UPF & SDC 
################################################################################################################

get_ports *clk*
read_sdc -echo ../script/dcr.sdc

## create_clock -period 1.0 -name clock [get_ports clk]

report_clock

check_design > ../report/check_design.rpt
check_timing > ../report/check_timing.rpt

group_path -from [all_registers] -to [all_registers] -name reg2reg
group_path -from [all_registers] -to [all_outputs] -name reg2out
group_path -from [all_inputs] -to [all_registers] -name in2reg
group_path -from [all_inputs] -to [all_outputs] -name in2out

remove_upf
load_upf ../script/dcr.upf

set_voltage 0.72 -object_list VDD
## set_voltage 0.585 -object_list VDDo
set_voltage 0.00 -object_list VSS

set_operating_conditions -max ss0p72v25c -min ss0p72v25c -library saed14lvt_base_ss0p72v25c

check_mv_design
check_mv_design -verbose

# setup verification format
set_svf dcr.svf

################################################################################################################
## Synthesis Process
################################################################################################################

## set_app_var auto_insert_level_shifters_on_clocks all

compile_ultra -no_autoungroup -no_boundary_optimization 

check_mv_design

report_level_shifter

report_clock_gating
report_timing
report_timing -delay_type min
report_area
report_design


################################################################################################################
## Analysis Design Report
################################################################################################################

report_area > ../report/area.rpt
report_hierarchy > ../report/hierarchy.rpt
report_design > ../report/design.rpt
report_timing > ../report/setup_timing.rpt
report_timing -delay_type min > ../report/hold_timing.rpt

################################################################################################################
## Generated Design Output
################################################################################################################

write_icc2_files -output ../output/dcr_allfiles.v
write_file -format verilog -hierarchy -output ../output/dcr_Netlist.v

write -hierarchy -format ddc -output ../output/dcr_hierarchy.ddc
write -hierarchy -format verilog -output ../output/dcr_hierarchy.v

write_sdc ../output/dcr.sdc
write_parasitics -output ../output/dcr_parasitics
write_sdf ../output/dcr.sdf