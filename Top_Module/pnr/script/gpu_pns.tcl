remove_pg_patterns -all
remove_pg_regions -all
remove_pg_strategies -all
remove_pg_strategy_via_rules -all
remove_pg_via_master_rules -all

remove_routes -net_types {power ground} -detail_route -global_route -shield_route -ring -stripe -lib_cell_pin_connect -macro_pin_connect

connect_pg_net

########################################### TOP RINGS #######################################################

create_pg_ring_pattern ring_pattern -horizontal_layer M7 \
   -horizontal_width {1} -horizontal_spacing {1} \
   -vertical_layer M8 -vertical_width {1} -vertical_spacing {1}

set_pg_strategy core_ring \
   -pattern {{name: ring_pattern} {nets: {VDD VDDH VSS}} {offset: {1 1}}} -core \
-extension {{nets: VDD VDDH VSS} {side : 2} {direction: R} {stop: design_boundary_and_generate_pin}}

compile_pg -strategies core_ring

################## MACRO DCR RINGS  ################################

create_pg_ring_pattern ring_pattern -horizontal_layer M7 \
   -horizontal_width {1} -horizontal_spacing {1} \
   -vertical_layer M8 -vertical_width {1} -vertical_spacing {1}

set_pg_strategy core_ring \
   -pattern {{name: ring_pattern} {nets: {VDD VSS}} {offset: {1 1}}} -macros dcr_instance\
-extension {{nets: VDD VSS} {side : 2} {direction: R} {stop: outermost_ring}}

compile_pg -strategies core_ring

################## MACRO DISPATCH RINGS ################################

create_pg_ring_pattern ring_pattern -horizontal_layer M7 \
   -horizontal_width {1} -horizontal_spacing {1} \
   -vertical_layer M8 -vertical_width {1} -vertical_spacing {1}

set_pg_strategy core_ring \
   -pattern {{name: ring_pattern} {nets: {VDD VSS}} {offset: {1 1}}} -macros dispatch_instance \
-extension {{nets: VDD VSS} {side : 2} {direction: R} {stop: outermost_ring}}

compile_pg -strategies core_ring

################## RAILS FOR DEFAULT AREA ###################################################################

create_pg_std_cell_conn_pattern rail_pattern -layers M1 -rail_width 0.10

set_pg_strategy M1_rails -voltage_areas DEFAULT_VA \
   -pattern {{name: rail_pattern} {nets: VDDH VSS}} \
   -blockage {{nets: VDDH VSS} {macros_with_keepout : dcr_instance dispatch_instance}} 

compile_pg -strategies M1_rails

################## RAILS FOR HIGH AREA ##########################

create_pg_std_cell_conn_pattern rail_pattern -layers M1 -rail_width 0.10

set_pg_strategy M1_rails -voltage_areas high \
   -pattern {{name: rail_pattern} {nets: VDD VSS}} \
   -blockage {{voltage_areas : DEFAULT_VA} {nets: VDD VSS}} 

compile_pg -strategies M1_rails

################## MESH FOR DEFAULT AREA #####################################################################

#remove_routes -stripe

create_pg_mesh_pattern mesh_pattern \
   -layers {{{vertical_layer: M6} {width: 0.14}\
             {pitch: 3} {offset: 3}{spacing:interleaving}}\
            {{horizontal_layer: M7} {width: 0.14}\
             {pitch: 3} {offset: 3}{spacing:interleaving}}}

set_pg_strategy M5M6_mesh \
   -pattern {{name: mesh_pattern} \
             {nets: VDDH VSS}} -voltage_area DEFAULT_VA \
   -extension {{nets:VDDH VSS} {stop: first_target} {direction: {T B L R}}} \
   -blockage {{nets: VDDH VSS} {voltage_areas : high}} 

compile_pg -strategies M5M6_mesh

################## MESH FOR HIGH AREA ############################

#remove_routes -stripe
#3 0.6
#2.96 0.6

create_pg_mesh_pattern mesh_pattern \
   -layers {{{vertical_layer: M6} {width: 0.14}\
             {pitch: 3} {offset: 0.1}{spacing:interleaving}}\
            {{horizontal_layer: M7} {width: 0.14}\
             {pitch: 2.96} {offset: 0.6}{spacing:interleaving}}}

set_pg_strategy M5M6_mesh \
   -pattern {{name: mesh_pattern} \
             {nets: VDD VSS}} -voltage_area high \
   -extension {{nets:VDD VSS} {stop: first_target} {direction:R} {side:3}} \
   -blockage {{voltage_areas : DEFAULT_VA} {nets: VDD VSS}} 

compile_pg -strategies M5M6_mesh

check_pg_connectivity