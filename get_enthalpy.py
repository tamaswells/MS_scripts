from xml.dom.minidom import parse
import glob
dom = parse(glob.glob('get_properties  Script/*Forcite Cell parameters.xcd')[0])
data = dom.documentElement
data2D = data.getElementsByTagName('DATA_2D')
SERIES=data2D[0].getElementsByTagName('SERIES_2D')
cell_a = []
for i in SERIES[0].getElementsByTagName('POINT_2D'):
    cell_a.append(list(map(float,i.getAttribute("XY").split(","))))
    
cell_b = []
for i in SERIES[1].getElementsByTagName('POINT_2D'):
    cell_b.append(list(map(float,i.getAttribute("XY").split(","))))
    
cell_c = []
for i in SERIES[2].getElementsByTagName('POINT_2D'):
    cell_c.append(list(map(float,i.getAttribute("XY").split(","))))

volume = []
for index in range(len(cell_a)):
    volume.append([cell_a[index][0],cell_a[index][1]*cell_b[index][1]*cell_c[index][1]])


dom = parse(glob.glob('get_properties  Script/*Forcite Pressure.xcd')[0])
data = dom.documentElement
data2D = data.getElementsByTagName('DATA_2D')
SERIES=data2D[0].getElementsByTagName('SERIES_2D')
pressure = []
for i in SERIES[0].getElementsByTagName('POINT_2D'):
    pressure.append(list(map(float,i.getAttribute("XY").split(","))))

dom = parse(glob.glob('get_properties  Script/*Forcite Potential energy components.xcd')[0])
data = dom.documentElement
data2D = data.getElementsByTagName('DATA_2D')
SERIES=data2D[0].getElementsByTagName('SERIES_2D')
potential_energy = []
for i in SERIES[1].getElementsByTagName('POINT_2D'):
    potential_energy.append(list(map(float,i.getAttribute("XY").split(","))))

dom = parse(glob.glob('get_properties  Script/*Forcite Total kinetic energy.xcd')[0])
data = dom.documentElement
data2D = data.getElementsByTagName('DATA_2D')
SERIES=data2D[0].getElementsByTagName('SERIES_2D')
kinetic_energy = []
for i in SERIES[0].getElementsByTagName('POINT_2D'):
    kinetic_energy.append(list(map(float,i.getAttribute("XY").split(","))))

enthalpy = []
for index in range(len(volume)):
    tmp = volume[index][1]*10**(-30)*pressure[index][1]*10**9*6.02214076*10**23/4.184/1000+potential_energy[index][1]+kinetic_energy[index][1]
    enthalpy.append([volume[index][0],tmp])
with open("enthalpy.txt","w") as writer:
    for i in enthalpy:
        writer.write("%f %f\n" %(i[0],i[1]))