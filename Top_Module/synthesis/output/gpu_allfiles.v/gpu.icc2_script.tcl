set _DCG_ICC2_DIR_ [file dirname [file normalize [info script]]]



##################################################################
# Read Design
##################################################################
if {[file exists ${_DCG_ICC2_DIR_}/gpu.v]} {
read_verilog ${_DCG_ICC2_DIR_}/gpu.v -top gpu
}



##################################################################
# Read settings
##################################################################
if {[file exists ${_DCG_ICC2_DIR_}/gpu.settings.tcl]} {
source -continue_on_error ${_DCG_ICC2_DIR_}/gpu.settings.tcl 
}



##################################################################
# Read UPF
##################################################################
if {[file exists ${_DCG_ICC2_DIR_}/gpu.upf]} {
load_upf ${_DCG_ICC2_DIR_}/gpu.upf 
commit_upf
}



##################################################################
# Read SDC
##################################################################
if {[file exists ${_DCG_ICC2_DIR_}/gpu.MCMM/top.tcl]} {
source -continue_on_error ${_DCG_ICC2_DIR_}/gpu.MCMM/top.tcl 
}



##################################################################
# Read Floorplan
##################################################################
if {[file exists ${_DCG_ICC2_DIR_}/gpu.floorplan/floorplan.tcl]} {
source -continue_on_error ${_DCG_ICC2_DIR_}/gpu.floorplan/floorplan.tcl 
}



##################################################################
# Read scan DEF
##################################################################
if {[file exists ${_DCG_ICC2_DIR_}/gpu.scan.def]} {
read_def ${_DCG_ICC2_DIR_}/gpu.scan.def 
}



##################################################################
# Read cell expansion data
##################################################################
if {[file exists ${_DCG_ICC2_DIR_}/gpu.cell.exp]} {
read_cell_expansion -input ${_DCG_ICC2_DIR_}/gpu.cell.exp 
}



