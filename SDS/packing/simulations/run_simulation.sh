module load VMD
module load NAMD
source activate /home/zulissi/.conda/envs/vmd_python

#Make the PSF/PDB files

#Run an equilibration (no biasing or anything), output goes to equilibration
#namd2 +p4 +devices 0 +idlepoll cnt_equilibrate.namd

#Run production run with biasing (output goes to ./output)

export PATH=/home/junwoony/Desktop/Linux-x86_64-icc/:$PATH

export PATH=/home/zulissi/software/namd/Linux-x86_64-icc/:$PATH

nohup namd2 +p4 +devices 0 +idlepoll cnt_eq.namd > output_eq.log &

nohup namd2 +p4 +devices 0 +idlepoll cnt.namd > output.log &

#To view the results, copy this folder to your local computer
# rsync -avP coe.psc.edu:~/surfactact_sim ~/
# Start vmd, file new molecule, select the PSF file, then right click on the molecule
# and click add file, then select the appropriate output file (the .dcd file in equilibration or output)
# or you can do this right away with vmd surfactant_sim/graphene_test/cnt_chains.psf surfactant_sim/graphene_test/output/cnt_abf.dcd
