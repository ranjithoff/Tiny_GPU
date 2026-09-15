if { [namespace current] != {::6A4B40C0} } { error {This script [file tail [info script]] should not be sourced directly}; }
###################################################################

# Created by write_script -format dctcl for global constraints on Mon Jul  6   \
11:14:32 2026

###################################################################

# Set the current_design #
current_design dcr

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
set_local_link_library                                                         \
{/home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_LVT/liberty/nldm/cg/saed14lvt_cg_ss0p72v25c.db,/home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_LVT/liberty/nldm/iso/saed14lvt_iso_ss0p72v25c.db,/home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_LVT/liberty/nldm/pg/saed14lvt_pg_ss0p72v25c.db,/home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_LVT/liberty/nldm/ret/saed14lvt_ret_ss0p72v25c.db,/home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_LVT/liberty/nldm/base/saed14lvt_base_ss0p72v25c.db,/home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_RVT/liberty/nldm/pg/saed14rvt_pg_ss0p72v25c.db,/home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_RVT/liberty/nldm/ret/saed14rvt_ret_ss0p72v25c.db,/home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_RVT/liberty/nldm/base/saed14rvt_base_ss0p72v25c.db,/home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_RVT/liberty/nldm/cg/saed14rvt_cg_ss0p72v25c.db,/home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_STD_RVT/liberty/nldm/iso/saed14rvt_iso_ss0p72v25c.db}
set_register_merging [current_design] 17
set_multibit_options -mode non_timing_driven
set_register_merging [get_cells {dcr_reg_reg[0]}] 17
set_register_merging [get_cells {dcr_reg_reg[1]}] 17
set_register_merging [get_cells {dcr_reg_reg[2]}] 17
set_register_merging [get_cells {dcr_reg_reg[3]}] 17
set_register_merging [get_cells {dcr_reg_reg[4]}] 17
set_register_merging [get_cells {dcr_reg_reg[5]}] 17
set_register_merging [get_cells {dcr_reg_reg[6]}] 17
set_register_merging [get_cells {dcr_reg_reg[7]}] 17
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
