colvarsTrajFrequency 1000
colvarsRestartFrequency 1000
smp on

colvar {
 name distZ
   # width 1
   # extendedLagrangian off
   # extendedFluctuation 0.01
        distanceZ {
                main {
                        atomsFile ../../SDS_graphene_wb.pdb
                        atomsCol B
                 atomsColValue 1 # O atom is assigned as they have beta = 1 in cnt_chains.pdb
    }

                ref {
                        atomsFile ../../SDS_graphene_wb.pdb
                 atomsCol B
                 atomsColValue 2 # C atoms are assigned as they have beta = 2 in cnt_chains.pdb

        }
    }
}



harmonic {
    name harmonic
    colvars distZ
   centers        15
    forceConstant 5
    outputCenters on
}

