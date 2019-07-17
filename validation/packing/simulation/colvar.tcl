
proc calc_moment {args} {

    upvar momentCV::moment moment
    upvar momentCV::xbox xbox
    upvar momentCV::ybox ybox

    set total 0.
    #set totals [list ]
    set args [lindex $args 0]

    #puts $args
    set l [llength $args]
    set natoms [expr $l/3]
    # puts $l
    for {set i 0} {$i<$l} {incr i 3} {
        set x [lindex $args $i]
        set y [lindex $args [expr $i+1]]
        #set x [expr abs($x)]
        #set x [expr $x-2*($x-$xbox)*($x>$xbox)]
        #set y [expr abs($y)]
        #set y [expr $y-2*($y-$ybox)*($y>$ybox)]
        set r [expr ($x**2.+$y**2.)**0.5]        
        set total [expr $total + pow($r/$xbox,$moment)]
    }
    set total [expr pow($total/$natoms,1./$moment)]
    return $total
}

proc calc_moment_gradient {args} {
    upvar momentCV::moment moment
    upvar momentCV::xbox xbox
    upvar momentCV::ybox ybox
    set grad {}
    set args [lindex $args 0]
    set l [llength $args] 
    set natoms [expr $l/3]

    set total 0
    set xvals [list ]
    set yvals [list ]  
    set rvals [list ]

    for {set i 0} {$i<$l} {incr i 3} {
        set x [lindex $args $i]
        set y [lindex $args [expr $i+1]]
        #set x [expr abs($x)]
        #set x [expr $x-2*($x-$xbox)*($x>$xbox)]
        #set y [expr abs($y)]
        #set y [expr $y-2*($y-$ybox)*($y>$ybox)]
        set r [expr ($x**2.+$y**2.)**0.5]
        lappend rvals $r
        set total [expr $total + pow($r/$xbox,$moment)]
        lappend xvals $x
        lappend yvals $y
    }

    set total [expr pow($xbox,-$moment)/$natoms*pow($total/$natoms,-1.+1./$moment)]
    foreach x $xvals y $yvals r $rvals {
        lappend grad [expr $total*$x*pow($r,-2+$moment)]
        lappend grad [expr $total*$y*pow($r,-2+$moment)]
        lappend grad 0
    }

    return [list $grad]
}
