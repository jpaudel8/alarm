
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name alarm -dir "C:/Users/Jagannath Paudel/Documents/fpga/alarm/planAhead_run_1" -part xc3s500efg320-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/Jagannath Paudel/Documents/fpga/alarm/top.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/Jagannath Paudel/Documents/fpga/alarm} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "top.ucf" [current_fileset -constrset]
add_files [list {top.ucf}] -fileset [get_property constrset [current_run]]
link_design
