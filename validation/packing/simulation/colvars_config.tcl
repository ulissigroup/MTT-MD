colvarsTrajFrequency 100


colvar {
    name  RGz
    width 0.1
    lowerboundary 5
    upperboundary 40
    #lowerwallconstant 0
    #upperwallconstant 0
    inertiaZ {
        atoms {  
            atomsFile test.pdb
            atomsCol B
            atomsColValue 1
        }
     }

}
