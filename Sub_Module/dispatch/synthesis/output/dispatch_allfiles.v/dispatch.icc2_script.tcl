set _DCG_ICC2_DIR_ [file dirname [file normalize [info script]]]



##################################################################
# Read Design
##################################################################
if {[file exists ${_DCG_ICC2_DIR_}/dispatch.v]} {
read_verilog ${_DCG_ICC2_DIR_}/dispatch.v -top dispatch
}



##################################################################
# Read settings
##################################################################
if {[file exists ${_DCG_ICC2_DIR_}/dispatch.settings.tcl]} {
source -continue_on_error ${_DCG_ICC2_DIR_}/dispatch.settings.tcl 
}



##################################################################
# Read UPF
##################################################################
if {[file exists ${_DCG_ICC2_DIR_}/dispatch.upf]} {
load_upf ${_DCG_ICC2_DIR_}/dispatch.upf 
commit_upf
}



##################################################################
# Read SDC
##################################################################
if {[file exists ${_DCG_ICC2_DIR_}/dispatch.MCMM/top.tcl]} {
source -continue_on_error ${_DCG_ICC2_DIR_}/dispatch.MCMM/top.tcl 
}



##################################################################
# Read Floorplan
##################################################################
if {[file exists ${_DCG_ICC2_DIR_}/dispatch.floorplan/floorplan.tcl]} {
source -continue_on_error ${_DCG_ICC2_DIR_}/dispatch.floorplan/floorplan.tcl 
}



##################################################################
# Read scan DEF
##################################################################
if {[file exists ${_DCG_ICC2_DIR_}/dispatch.scan.def]} {
read_def ${_DCG_ICC2_DIR_}/dispatch.scan.def 
}



##################################################################
# Read cell expansion data
##################################################################
if {[file exists ${_DCG_ICC2_DIR_}/dispatch.cell.exp]} {
read_cell_expansion -input ${_DCG_ICC2_DIR_}/dispatch.cell.exp 
}



