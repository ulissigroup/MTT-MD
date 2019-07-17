set num_replicas 17
set final 20

for {set i 0} {$i < $num_replicas} {incr i} {

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


}

