colvarsTrajFrequency 100
colvarsRestartFrequency 1000
smp off

colvar {
    name  moment
    #timestepfactor 10
    width 0.05
    lowerboundary 0.2
    upperboundary 0.9
    lowerwallconstant 100
    upperwallconstant 10000
    extendedLagrangian on
    extendedFluctuation 0.001
    scriptedFunction  moment
    cartesian {  
        atoms {
            atomsFile cnt_chains.pdb
            atomsCol B
            atomsColValue 1
        }
    }

}


abf {
    name densityABF
    #timestepfactor 10
    colvars moment
    historyFreq 500
    outputFreq 1000
    fullSamples 200
}



#colvar {
#    name  distZ    
#    distanceZ {
#        main {
#                atomsFile cnt_chains.pdb
#                atomsCol B
#                atomsColValue 1
#        }
#        ref {
#               atomsFile cnt_chains.pdb
#                atomsCol B
#                atomsColValue 2
#        }
#        forceNoPBC yes
#    }
#    #timestepfactor 10
#    width 0.1
#    lowerboundary 0.01
#    upperboundary 3.75
#    lowerwallconstant 0.1
#    upperwallconstant 100.
#}
