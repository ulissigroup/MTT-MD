import numpy as np

file=open('energies.txt')
data=[]
for line in file:
    data.append(map(float,line.split()[1:]))

data = np.array(data)

temp = data[:,11]

# plot things in matplotlib
