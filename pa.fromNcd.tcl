
# PlanAhead Launch Script for Post PAR Floorplanning, created by Project Navigator

create_project -name alarm -dir "C:/Users/Jagannath Paudel/Documents/fpga/alarm/planAhead_run_1" -part xc3s500efg320-4
set srcset [get_property srcset [current_run -impl]]
set_property design_mode GateLvl $srcset
set_property edif_top_file "C:/Users/Jagannath Paudel/Documents/fpga/alarm/top.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/Jagannath Paudel/Documents/fpga/alarm} }
set_property target_constrs_file "top.ucf" [current_fileset -constrset]
add_files [list {top.ucf}] -fileset [get_property constrset [current_run]]
link_design
read_xdl -file "C:/Users/Jagannath Paudel/Documents/fpga/alarm/top.ncd"
if {[catch {read_twx -name results_1 -file "C:/Users/Jagannath Paudel/Documents/fpga/alarm/top.twx"} eInfo]} {
   puts "WARNING: there was a problem importing \"C:/Users/Jagannath Paudel/Documents/fpga/alarm/top.twx\": $eInfo"
}
