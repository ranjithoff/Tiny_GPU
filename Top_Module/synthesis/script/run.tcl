###############################################################################################################
# Tiny GPU Project : TOP MODULE
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
	            [glob /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_RVT/liberty/nldm/*/saed14rvt_*_ss0p72v25c.db] \
		  [glob /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_LVT/liberty/nldm/*/saed14lvt_*_ss0p585v25c.db] \
                      [glob /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_RVT/liberty/nldm/*/saed14rvt_*_ss0p585v25c.db] \
		  /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_LVT/liberty/nldm/ulvl/saed14lvt_ulvl_ss0p72v25c_i0p585v.db \ 
                      /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_LVT/liberty/nldm/dlvl/saed14lvt_dlvl_ss0p585v25c_i0p72v.db \
                      /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_RVT/liberty/nldm/ulvl/saed14rvt_ulvl_ss0p72v25c_i0p585v.db \ 
                      /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_RVT/liberty/nldm/dlvl/saed14rvt_dlvl_ss0p585v25c_i0p72v.db \
                      /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_LVT/liberty/nldm/ulvl/saed14lvt_ulvl_ss0p585v25c_i0p585v.db \
                      /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_LVT/liberty/nldm/dlvl/saed14lvt_dlvl_ss0p585v25c_i0p585v.db \
                      /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_RVT/liberty/nldm/ulvl/saed14rvt_ulvl_ss0p585v25c_i0p585v.db \
                      /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_RVT/liberty/nldm/dlvl/saed14rvt_dlvl_ss0p585v25c_i0p585v.db " 

set link_library  " [glob /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_LVT/liberty/nldm/*/saed14lvt_*_ss0p72v25c.db] \
	            [glob /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_RVT/liberty/nldm/*/saed14rvt_*_ss0p72v25c.db] \
		  [glob /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_LVT/liberty/nldm/*/saed14lvt_*_ss0p585v25c.db] \
                      [glob /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_RVT/liberty/nldm/*/saed14rvt_*_ss0p585v25c.db] \
		  /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_LVT/liberty/nldm/ulvl/saed14lvt_ulvl_ss0p72v25c_i0p585v.db \ 
                      /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_LVT/liberty/nldm/dlvl/saed14lvt_dlvl_ss0p585v25c_i0p72v.db \
                      /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_RVT/liberty/nldm/ulvl/saed14rvt_ulvl_ss0p72v25c_i0p585v.db \ 
                      /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_RVT/liberty/nldm/dlvl/saed14rvt_dlvl_ss0p585v25c_i0p72v.db \
                      /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_LVT/liberty/nldm/ulvl/saed14lvt_ulvl_ss0p585v25c_i0p585v.db \
                      /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_LVT/liberty/nldm/dlvl/saed14lvt_dlvl_ss0p585v25c_i0p585v.db \
                      /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_RVT/liberty/nldm/ulvl/saed14rvt_ulvl_ss0p585v25c_i0p585v.db \
                      /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_RVT/liberty/nldm/dlvl/saed14rvt_dlvl_ss0p585v25c_i0p585v.db \
                     $synthetic_library "
                        
################################################################################################################
## Creating Library
################################################################################################################

create_lib -technology $TECH_FILE -ref_libs $REFERENCE_LIBRARY gpu.dlib 

################################################################################################################
## RC parasitics, placement site and routing layer setup
################################################################################################################

set_tlu_plus_files -tech2itf_map /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_TECH_DATA/map/saed14nm_tf_itf_tluplus.map \
-max_tluplus /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_TECH_DATA/tlup/saed14nm_1p9m_Cmax.tlup  \
-min_tluplus /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_TECH_DATA/tlup/saed14nm_1p9m_Cmin.tlup 
		
################################################################################################################
## Read/Convert to WV GEtech/Connet Sub block to TOP block
################################################################################################################

read_ddc " ../../../submodule/dcr/synthesis/output/dcr_hierarchy.ddc "
read_ddc " ../../../submodule/dispatch/synthesis/output/dispatch_hierarchy.ddc "

analyze -format sverilog [glob ../../rtl/*.sv]

## analyze -format sverilog [glob ../../../rtl/*.sv]
## analyze -format verilog [glob ../../../rtl/*.v]

elaborate gpu
link
current_design

################################################################################################################
## Constraint Files UPF & SDC 
################################################################################################################

get_ports *clk*
read_sdc -echo ../script/gpu.sdc

## create_clock -period 1.0 -name clock [get_ports clk]

report_clock

check_design > ../report/check_design.rpt
check_timing > ../report/check_timing.rpt

group_path -from [all_registers] -to [all_registers] -name reg2reg
group_path -from [all_registers] -to [all_outputs] -name reg2out
group_path -from [all_inputs] -to [all_registers] -name in2reg
group_path -from [all_inputs] -to [all_outputs] -name in2out

remove_upf
load_upf ../script/gpu.upf

set_voltage 0.585 -object_list VDDH
set_voltage 0.72 -object_list VDD
set_voltage 0.00 -object_list VSS

create_operating_conditions -name min -library saed14rvt_base_ss0p585v25c -process 0.5 -temperature 25 -voltage 0.585
create_operating_conditions -name max -library saed14lvt_base_ss0p72v25c -process 0.5 -temperature 25 -voltage 0.72
set_operating_conditions -max max -min min

## set_operating_conditions -max ss0p585v25c -min ss0p585v25c -library saed14lvt_base_ss0p585v25c

check_mv_design
check_mv_design -verbose

# setup verification format
set_svf gpu.svf

################################################################################################################
## Synthesis Process
################################################################################################################

set_app_var auto_insert_level_shifters_on_clocks all

compile_ultra -no_autoungroup -no_boundary_optimization -self_gating -gate_clock -exact_map 

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

write_icc2_files -output ../output/gpu_allfiles.v
write_file -format verilog -hierarchy -output ../output/gpu_Netlist.v

write -hierarchy -format ddc -output ../output/gpu_hierarchy.ddc
write -hierarchy -format verilog -output ../output/gpu_hierarchy.v

write_sdc ../output/gpu.sdc
write_parasitics -output ../output/gpu_parasitics
write_sdf ../output/gpu.sdf