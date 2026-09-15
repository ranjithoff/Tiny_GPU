set _DCG_ICC2_DIR_ [file dirname [file normalize [info script]]]



##################################################################
# Read Design
##################################################################
if {[file exists ${_DCG_ICC2_DIR_}/dcr.v]} {
read_verilog ${_DCG_ICC2_DIR_}/dcr.v -top dcr
}



##################################################################
# Read settings
##################################################################
if {[file exists ${_DCG_ICC2_DIR_}/dcr.settings.tcl]} {
source -continue_on_error ${_DCG_ICC2_DIR_}/dcr.settings.tcl 
}



##################################################################
# Read UPF
##################################################################
if {[file exists ${_DCG_ICC2_DIR_}/dcr.upf]} {
load_upf ${_DCG_ICC2_DIR_}/dcr.upf 
commit_upf
}



##################################################################
# Read SDC
##################################################################
if {[file exists ${_DCG_ICC2_DIR_}/dcr.MCMM/top.tcl]} {
source -continue_on_error ${_DCG_ICC2_DIR_}/dcr.MCMM/top.tcl 
}



##################################################################
# Read Floorplan
##################################################################
if {[file exists ${_DCG_ICC2_DIR_}/dcr.floorplan/floorplan.tcl]} {
source -continue_on_error ${_DCG_ICC2_DIR_}/dcr.floorplan/floorplan.tcl 
}



##################################################################
# Read scan DEF
##################################################################
if {[file exists ${_DCG_ICC2_DIR_}/dcr.scan.def]} {
read_def ${_DCG_ICC2_DIR_}/dcr.scan.def 
}



##################################################################
# Read cell expansion data
##################################################################
if {[file exists ${_DCG_ICC2_DIR_}/dcr.cell.exp]} {
read_cell_expansion -input ${_DCG_ICC2_DIR_}/dcr.cell.exp 
}



