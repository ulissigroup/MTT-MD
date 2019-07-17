set num_windows 26
set k 2.5
set lowerboundary 4
set upperboundary 29

set INPUT [open "INPUT_6ns_$k" w]

puts $INPUT "\#\# wham $lowerboundary $upperboundary 180 0.0001 300.0 0 INPUT_6ns_$k Umbrella_$k.pmf"
puts $INPUT "\#\#/path/to/timeseries/file loc_win_min spring \[correl time\] \[temp\]"
puts $INPUT "\#\#"

for {set i 0} {$i < $num_windows} {incr i} {
		puts $INPUT "../output_umbrella/$i/win$i.colvars.traj [expr 29 - $i] $k"
	}


close $INPUT
