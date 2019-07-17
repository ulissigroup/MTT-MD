colvarsTrajFrequency 1000
colvarsRestartFrequency 1000
smp on

colvar {
    name  moment
    width 1
   # extendedLagrangian off
   # extendedFluctuation 0.01
    gyrationP_xy {
        P 12
        name c
        atoms {
            atomsFile ../../SDS_graphene_wb.pdb
            atomsCol B
            atomsColValue 1
        }
    }
}
harmonic {
    name harmonic
    colvars moment
    centers CENTER
    forceConstant 5
    outputCenters on
}

