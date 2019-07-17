set num_replicas 28
set final 40

for {set i 0} {$i < $num_replicas} {incr i} {

## write the angle files
  set in0 [open "../angle-US.tcl" r]
  set out [open "../output_umbrella/${i}/angle.tcl" w]
  puts $out "set num $i"
  while { [gets $in0 line] >= 0} {
    puts $out $line
  }
  close $out


## write the config files
  set in1 [open "../cnt-US.namd" r]
  set out [open "../output_umbrella/${i}/run_namd.conf" w]
  puts $out "set num $i"
  while { [gets $in1 line] >= 0} {
    puts $out $line
  } 
  close $out

## write the colvars input files      
  set in2 [open "../colvars-packing-US.tcl" r]
  set out [open "../output_umbrella/${i}/colvars.tcl" w]
  while { [gets $in2 line] >= 0} {
    if { [string match "*CENTER*" $line]} {
      puts $out "   centers        [expr $final - $i]"
    } else {  
      puts $out $line
    }
  }

## write the sasa files
  set in3 [open "../sasa-US.tcl" r]
  set out [open "../output_umbrella/${i}/sasa.tcl" w]
  puts $out "set num $i"
  while { [gets $in3 line] >= 0} {
    puts $out $line
  }
  close $out



}

