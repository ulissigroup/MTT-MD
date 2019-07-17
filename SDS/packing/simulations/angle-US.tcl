mol new ../../SDS_graphene_wb.psf
mol addfile win${num}.dcd waitfor all


set num_molecules 30
set outfile [open angle${num}.dat w]
set pi [expr acos(-1)]

puts $outfile "# frame \t angles"

for {set i 0} {$i < [molinfo top get numframes] } {incr i 1 } {
        set sum 0
        set count 0
	set curlist [list]
        for {set r 0} {$r < $num_molecules} {incr r 1} {
            set sel [atomselect top "resid $r and type SL CTL3" frame [expr $i]]
            set minmax [measure minmax $sel]
	            set height [expr [lindex [lindex $minmax 1] 2] - [lindex [lindex $minmax 0] 2]]
        	    set diff_x [expr [lindex [lindex $minmax 1] 0] - [lindex [lindex $minmax 0] 0]]
	            set diff_y [expr [lindex [lindex $minmax 1] 1] - [lindex [lindex $minmax 0] 1]]
        	    set adjacent [expr sqrt($diff_x * $diff_x + $diff_y * $diff_y)]
           	    set angle [expr atan($height/$adjacent)*180/$pi]
	 	    lappend curlist [format "%.4f" $angle]
		    incr count 1
	}
         if { $count != 0} {
                puts $outfile "[expr $i*1000] $curlist"
        }

}

quit


