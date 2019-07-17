
if (( $# != 1 )); then {
  echo "usage: $0 <num_window>"
  exit -1
}; fi


for (( i=0; i<$1; ++i )); do cd $i; sbatch submit_calc.sh; cd ../;done
#for (( i=0; i<$1; ++i )); do cd ../;done

#do sbatch submit_calc.sh
#do cd ../} #done

