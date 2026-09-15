if { [namespace current] != {::6A4B425D} } { error {This script [file tail [info script]] should not be sourced directly}; }
###################################################################

# Created by write_script -format dctcl for global constraints on Mon Jul  6   \
11:21:25 2026

###################################################################

# Set the current_design #
current_design dispatch

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
set_local_link_library                                                         \
{/home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_LVT/liberty/nldm/cg/saed14lvt_cg_ss0p72v25c.db,/home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_LVT/liberty/nldm/iso/saed14lvt_iso_ss0p72v25c.db,/home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_LVT/liberty/nldm/pg/saed14lvt_pg_ss0p72v25c.db,/home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_LVT/liberty/nldm/ret/saed14lvt_ret_ss0p72v25c.db,/home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_LVT/liberty/nldm/base/saed14lvt_base_ss0p72v25c.db,/home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_RVT/liberty/nldm/pg/saed14rvt_pg_ss0p72v25c.db,/home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_RVT/liberty/nldm/ret/saed14rvt_ret_ss0p72v25c.db,/home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_RVT/liberty/nldm/base/saed14rvt_base_ss0p72v25c.db,/home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_RVT/liberty/nldm/cg/saed14rvt_cg_ss0p72v25c.db,/home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_RVT/liberty/nldm/iso/saed14rvt_iso_ss0p72v25c.db}
set_register_merging [current_design] 17
set_multibit_options -mode non_timing_driven
set_register_merging [get_cells {core_start_reg[3]}] 17
set_register_merging [get_cells {core_thread_count_reg[3][0]}] 17
set_register_merging [get_cells {blocks_dispatched_reg[3]}] 17
set_register_merging [get_cells {blocks_dispatched_reg[4]}] 17
set_register_merging [get_cells {blocks_done_reg[4]}] 17
set_register_merging [get_cells {core_thread_count_reg[1][0]}] 17
set_register_merging [get_cells {core_thread_count_reg[1][1]}] 17
set_register_merging [get_cells {core_thread_count_reg[1][2]}] 17
set_register_merging [get_cells {core_thread_count_reg[2][0]}] 17
set_register_merging [get_cells {core_thread_count_reg[2][1]}] 17
set_register_merging [get_cells {core_thread_count_reg[2][2]}] 17
set_register_merging [get_cells {core_start_reg[1]}] 17
set_register_merging [get_cells {core_start_reg[2]}] 17
set_register_merging [get_cells {core_block_id_reg[0][1]}] 17
set_register_merging [get_cells {core_block_id_reg[0][2]}] 17
set_register_merging [get_cells {core_block_id_reg[0][3]}] 17
set_register_merging [get_cells {core_block_id_reg[0][4]}] 17
set_register_merging [get_cells {core_block_id_reg[0][5]}] 17
set_register_merging [get_cells {core_block_id_reg[0][0]}] 17
set_register_merging [get_cells {core_block_id_reg[1][1]}] 17
set_register_merging [get_cells {core_block_id_reg[1][2]}] 17
set_register_merging [get_cells {core_block_id_reg[1][3]}] 17
set_register_merging [get_cells {core_block_id_reg[1][4]}] 17
set_register_merging [get_cells {core_block_id_reg[1][5]}] 17
set_register_merging [get_cells {core_block_id_reg[2][1]}] 17
set_register_merging [get_cells {core_block_id_reg[2][2]}] 17
set_register_merging [get_cells {core_block_id_reg[2][3]}] 17
set_register_merging [get_cells {core_block_id_reg[2][4]}] 17
set_register_merging [get_cells {core_block_id_reg[2][5]}] 17
set_register_merging [get_cells {core_block_id_reg[1][0]}] 17
set_register_merging [get_cells {core_block_id_reg[2][0]}] 17
set_register_merging [get_cells {blocks_dispatched_reg[6]}] 17
set_register_merging [get_cells {core_block_id_reg[3][1]}] 17
set_register_merging [get_cells {core_block_id_reg[3][2]}] 17
set_register_merging [get_cells {core_block_id_reg[3][3]}] 17
set_register_merging [get_cells {core_block_id_reg[3][4]}] 17
set_register_merging [get_cells {core_block_id_reg[3][5]}] 17
set_register_merging [get_cells {core_block_id_reg[3][0]}] 17
set_register_merging [get_cells {core_thread_count_reg[0][0]}] 17
set_register_merging [get_cells {core_thread_count_reg[0][1]}] 17
set_register_merging [get_cells {core_thread_count_reg[0][2]}] 17
set_register_merging [get_cells {blocks_done_reg[1]}] 17
set_register_merging [get_cells {blocks_done_reg[2]}] 17
set_register_merging [get_cells {blocks_done_reg[3]}] 17
set_register_merging [get_cells {blocks_done_reg[5]}] 17
set_register_merging [get_cells {blocks_done_reg[6]}] 17
set_register_merging [get_cells {blocks_done_reg[7]}] 17
set_register_merging [get_cells {blocks_done_reg[0]}] 17
set_register_merging [get_cells {core_start_reg[0]}] 17
set_register_merging [get_cells {core_thread_count_reg[3][1]}] 17
set_register_merging [get_cells {core_thread_count_reg[3][2]}] 17
set_register_merging [get_cells {core_reset_reg[1]}] 17
set_register_merging [get_cells {core_reset_reg[2]}] 17
set_register_merging [get_cells {core_reset_reg[3]}] 17
set_register_merging [get_cells {blocks_dispatched_reg[1]}] 17
set_register_merging [get_cells {blocks_dispatched_reg[2]}] 17
set_register_merging [get_cells {blocks_dispatched_reg[5]}] 17
set_register_merging [get_cells {blocks_dispatched_reg[0]}] 17
set_register_merging [get_cells {core_reset_reg[0]}] 17
set_register_merging [get_cells start_latch_reg] 17
set_register_merging [get_cells done_reg] 17
if {[info exists synopsys_program_name]} {
set_design_attributes -elements {.} -attribute lower_domain_boundary false
}
create_supply_net VDD 
create_supply_net VSS 
create_power_domain PD -include_scope
set_domain_supply_net [get_power_domains PD]  -primary_power_net               \
[get_supply_nets VDD]  -primary_ground_net [get_supply_nets VSS]
create_supply_port VDD  -domain [get_power_domains PD]  -direction in
create_supply_port VSS  -domain [get_power_domains PD]  -direction in
connect_supply_net [get_supply_nets VDD] -ports VDD
connect_supply_net [get_supply_nets VSS] -ports VSS
set_always_on_strategy -object_list [get_power_domains PD]  -cell_type         \
dual_power
set compile_inbound_cell_optimization false
set compile_inbound_max_cell_percentage 10.0
