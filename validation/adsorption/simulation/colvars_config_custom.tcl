colvarsTrajFrequency 100
colvarsRestartFrequency 1000
smp off



colvar {
    name  particleZ    
    distanceZ {
        main {
                atomsFile cnt_chains.pdb
                atomsCol B
                atomsColValue 1
        }
        ref {
               atomsFile cnt_chains.pdb
                atomsCol B
                atomsColValue 2
        }
        forceNoPBC yes
    }
    #timestepfactor 10
    #width 0.1
    lowerboundary 1
    upperboundary 12
    lowerwallconstant 5
    upperwallconstant 5
}






abf {
    name densityABF
    #timestepfactor 10
    colvars particleZ
    historyFreq 500
    outputFreq 1000
    fullSamples 200
}

