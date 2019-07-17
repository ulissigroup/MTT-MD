mol new ../../SDS_graphene_wb.psf
mol addfile win${num}.dcd waitfor all

set outfile [open sasa${num}.dat w]

puts $outfile "# frame \t rad \t sasa"

for {set i 0} {$i < [molinfo top get numframes] } {incr i 1 } {
        set count 0 
        set sasalist [list]
        set rlist [list]
        set allsel [atomselect top all frame [expr $i]]
        set sds [atomselect top "segid SDS" frame [expr $i]]
        set rsasa [measure sasa 1.4 $allsel -restrict $sds]
        set r [measure rgyr $sds]
        lappend rlist [format "%.4f" $r]
        lappend sasalist [format "%.4f" $rsasa]
        incr count 1
 
         if { $count != 0} {
                puts $outfile "[expr $i*1000] $rlist $sasalist"
         }
}

quit


