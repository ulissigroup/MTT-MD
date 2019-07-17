proc writeXSC { j fr } {
  set outXSC [open "win${j}.restart.xsc" w]
  animate goto $fr
  puts $outXSC "\# NAMD extended system configuration output file"
  puts $outXSC "\#\$LABELS step a_x a_y a_z b_x b_y b_z c_x c_y c_z o_x o_y o_z s_x s_y s_z s_u s_v s_w"
  puts $outXSC "0 [molinfo top get a] 0 0 0 [molinfo top get b] 0 0 0 [molinfo top get c] [lindex [molinfo top get center] 0 0] [lindex [molinfo top get center] 0 1] [lindex [molinfo top get center] 0 2] 0 0 0 0 0 0"
  close $outXSC
}

set initial_distance 13
set final_distance 40


## load files here

mol new ../SDS_graphene_wb.psf
mol addfile ../output/cntabf_packing.dcd waitfor all

# Load trajectory file to parse trajectories
# make coordinate files for each window
set traj [open ../output/cntabf_packing.colvars.traj r]
set data [read $traj]
set ns [llength [split $data "\n"]]
set line [split $data "\n"]
set outdist [open window-info.dat w]

set nf 0
for {set i 0} {$i < $ns } {incr i 1} {
# Extract trajectories and frame numbers
    if { [lindex [lindex $line $i] 0] != "#" && [lindex [lindex $line $i] 0] != [lindex [lindex $line [expr $i+1]] 0]} {
            set distZ [lindex [lindex $line $i] 1]
            for {set j $initial_distance } {$j <= $final_distance } {incr j } {
## note that this tolerance may need to be changed to capture all windows
                if {[expr abs($distZ - $j)] < 0.1} {
                     set num [expr $final_distance-$j]
                     puts $outdist "frame:$nf center:$j distz:$distZ diff:[expr abs($distZ - $j)] window:$num"
                     set all [atomselect top all frame $nf]
                     $all writenamdbin win${num}.restart.coor
                     writeXSC $num $nf

    }
   }
  incr nf 1
 }
}

quit


