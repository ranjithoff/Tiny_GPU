remove_pg_patterns -all
remove_pg_regions -all
remove_pg_strategies -all
remove_pg_strategy_via_rules -all
remove_pg_via_master_rules -all

remove_routes  -net_types {power ground} -detail_route -global_route -ring -stripe -lib_cell_pin_connect -macro_pin_connect

connect_pg_net

################ rail ###################

create_pg_std_cell_conn_pattern rail_pattern -layers M1 -rail_width 0.10

set_pg_strategy M1_rails -core \
   -pattern {{name: rail_pattern}{nets: VDD VSS}}

compile_pg -strategies M1_rails

################ mesh ###################

create_pg_mesh_pattern mesh_pattern \
   -layers {{{vertical_layer: M8} {width: 0.2}\
             {pitch: 10} {offset: 4}{spacing: interleaving}}\
            {{horizontal_layer: M7} {width: 0.2}\
             {pitch: 9} {offset: 4.5}{spacing: interleaving}}}

set_pg_strategy M5M6_mesh \
   -pattern {{name: mesh_pattern} {nets: VDD VSS}} -core \
-extension {{side : 4}{nets: VDD VSS}  {direction: T B L R} {stop:design_boundary_and_generate_pin}}

compile_pg -strategies M5M6_mesh

