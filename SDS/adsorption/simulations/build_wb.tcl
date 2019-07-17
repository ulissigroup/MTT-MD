package require nanotube
package require topotools
package require pbctools
package require solvate

proc linspace {min max nb} {

    if {$min > $max} then {
      error "The minimum value is $min but the maximum value is $max"
    }

    set step [expr {($max-$min)/($nb-1)}]

    set result {}
    set current $min
    while {1} {
      lappend result $current
      set current [expr {$current + $step}]
      if {$current > $max} then {
        break
      }
    }
    return $result
}

# If we want to allow flexible graphene sheets, we need the bonds/etc to be correct. The auto
# generated values will not be periodic, so we'll do them ourselves
set NT [graphene -lx 10 -ly 10 -type zigzag -nlayers 1 -b 0 -a 0 -d 0 -i 0]

#Call graphene atoms type CG to distinguish from benzene CA
[atomselect top all] set type CG
set boxheight 20.0

set CCdist 1.42
set sel [atomselect top all]
set minmax [measure minmax $sel]

#ZU small typos in this line
set pbcx [expr [lindex [lindex $minmax 1] 0]-[lindex [lindex $minmax 0] 0] +$CCdist]
set pbcy [expr [lindex [lindex $minmax 1] 1]-[lindex [lindex $minmax 0] 1] +$CCdist*sin(60.0/360.0*2*3.1415)]

pbc set [list $pbcx $pbcy $boxheight]

#We want to make sure there are bonds between atoms in the graphene sheet, and more importantly 
# we want bonds across the periodic boundary conditions. This script adds bonds between the carbon
# atoms and ensures ones across the boundaries are included
set allatoms [atomselect top all]
topo clearbonds
foreach ind [$allatoms get index] {
    set sel [atomselect top "pbwithin 1.5 of index $ind"] 
    foreach secondind [$sel get index] {
        topo addbond $ind $secondind
    } 
}
#Now that the bonds are in place, topotools can guess the angles/dihedrals/impropers
topo guessangles
topo guessdihedrals
topo guessimpropers 


#Combine solvated graphene with SDS molecules

#I adjusted z0 up a little so that the sulfate group didn't overlap the sheet.
# we could also guess this by looking at the minpos of the surfactant

# I also moved the position of the sodium atom closer to the sulfate group so that it ends up on the correct side of the graphene sheet (near the negative charge)
set z0 11
set sdsid 0

#It's important that all of the SDS molecules are within the bounds of the graphene sheet
# the previous parameters had some of the SDS off the sheet, so the water box also went past the sheet

#foreach x [linspace 1. [expr $pbcx-$pbcx/2.] 1] {
#    foreach y [linspace 1. [expr $pbcy-$pbcy/2.] 1] {
set x [expr $pbcx/2]
set y [expr $pbcy/2]
        set sds [mol new SDS.psf]
        mol addfile SDS.pdb
        set sel [atomselect top all]
        $sel moveby [list $x $y $z0]
        $sel set resid $sdsid
        incr sdsid
#    }
#}

set mollist [molinfo list]
::TopoTools::mergemols $mollist
foreach molid $mollist {
mol delete $molid
}


animate write psf SDS_graphene.psf
animate write pdb SDS_graphene.pdb
mol delete all

#solvate SDS_graphene.psf SDS_graphene.pdb -z 21 +z 20 +x 5 -x 5 +y 5 -y 5 -o SDS_graphene_wb
solvate SDS_graphene.psf SDS_graphene.pdb -z 11 +z 20 +x 3 -x 3 +y 3 -y 3 -o SDS_graphene_wb


#set the PBC. Use the X/Y of the graphene sheet, and the Z from the solvate box, +3 Ang so that the water at the 
# top does not overlap the the graphene sheet in the next cell
puts [pbc get]
pbc set [list $pbcx $pbcy [expr [lindex [pbc get] 0 2]+2.]]
puts [pbc get]


set sel [atomselect top "segid SHT"]
$sel set beta 2
$sel set occupancy 1
$sel set type CG

set sel [atomselect top "segid SDS"]
$sel set beta 1
$sel set occupancy 0
set sel [atomselect top "type SOD"]
$sel set beta 0
$sel set segid SOD
set sel [atomselect top "type OT HT"]
$sel set occupancy 0


[atomselect top all] moveby [vecsub {0 0 0} [measure center [atomselect top all]]]

animate write pdb SDS_graphene_wb.pdb
animate write pdb SDS_graphene_wb.fixed.pdb
animate write psf SDS_graphene_wb.psf

pbc writexst SDS_graphene_wb.xst

set sel [atomselect top "type CG"]
#$sel set z 0.
#$sel set y 0.
$sel set occupancy 0
set sel [atomselect top "type SL"]
# 0.001 gives 0.00
$sel set occupancy 0.01

animate write pdb SDS_graphene_wb_cons.pdb

quit
