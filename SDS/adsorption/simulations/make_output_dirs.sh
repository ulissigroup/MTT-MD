
if (( $# != 2 )); then {
  echo "usage: $0 <output_dir> <num_replicas>"
  exit -1
}; fi

mkdir $1

for (( i=0; i<$2; ++i )); do mkdir $1/$i; done
for (( i=0; i<$2; ++i )); do cp submit_calc.sh $1/$i; done
for (( i=0; i<1; ++i )); do mkdir $1/traj; cp submit_all.sh $1; cp write-input.tcl $1; cp copy_traj.sh $1;done
