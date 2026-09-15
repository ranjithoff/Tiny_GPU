create_workspace -technology /home1/SAED14_EDK/SAED14_EDK/SAED14nm_EDK_TECH_DATA/tf/saed14nm_1p9m.tf -flow normal dispatch_ndm
read_gds ../../pnr/output/dispatch.gds
set_attribute [get_lib_cells dispatch] design_type macro
check_workspace
commit_workspace -output ../output/dispatch.ndm