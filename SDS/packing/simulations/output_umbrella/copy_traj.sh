
if (( $# != 1 )); then {
  echo "usage: $0 <num_window>"
  exit -1
}; fi


for (( i=0; i<$1; ++i )); do cp $i/win$i.colvars.traj traj;done


