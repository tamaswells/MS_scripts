from ase.io import read,write
frames = read('trj.txt',format="extxyz",index=':')
for i in frames:
    write("a.gro",i,append=True)
    with open("a.gro","a+") as writer:
        writer.write("\n")