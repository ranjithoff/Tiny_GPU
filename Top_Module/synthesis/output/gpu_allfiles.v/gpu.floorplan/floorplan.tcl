##################################################################
##  Created by: Design Compiler (R) NXT (Topographical)
##  Version: T-2022.03-SP4
##  Design: gpu
##  Date: Tue Jul  7 10:01:49 2026
##  Command: write_floorplan
##################################################################
set _dirName__0 [file dirname [file normalize [info script]]]


################################################################################
# Site def
################################################################################




################################################################################
# Read DEF
################################################################################


read_def -allow_cell_creation ${_dirName__0}/floorplan.def


################################################################################
# Bounds
################################################################################




################################################################################
# Route guides
################################################################################




################################################################################
# Blockages
################################################################################




################################################################################
# Voltage areas
################################################################################




################################################################################
# RP groups
################################################################################


if {[file exists ${_dirName__0}/rp.tcl]} {
source ${_dirName__0}/rp.tcl
}


################################################################################
# User Shapes
################################################################################




################################################################################
# Routing directions
################################################################################


set_attribute [get_layer M1] routing_direction vertical
set_attribute [get_layer M2] routing_direction horizontal
set_attribute [get_layer M3] routing_direction vertical
set_attribute [get_layer M4] routing_direction horizontal
set_attribute [get_layer M5] routing_direction vertical
set_attribute [get_layer M6] routing_direction horizontal
set_attribute [get_layer M7] routing_direction vertical
set_attribute [get_layer M8] routing_direction horizontal
set_attribute [get_layer M9] routing_direction vertical
set_attribute [get_layer MRDL] routing_direction horizontal


################################################################################
# Routing Rules
################################################################################


source ${_dirName__0}/routing_rule.tcl
source ${_dirName__0}/routing_rule.net.tcl
source ${_dirName__0}/routing_rule.layer.tcl
