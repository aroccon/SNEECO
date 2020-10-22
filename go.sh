#!/bin/bash
#Parameters
machine="0"         #### 0=OS X 1=UNIX
dist_flag="0"       #### Distribution 0-Lognormal
fluid_flag="1"      #### Fluid velocity 0-off
vap_flag="0"        #### Evaporation 0-off 1-on
temp_flag="0"       #### Temperatur flag 0-off 1-on
dump="1000"           #### Dump of particle location/velocity/diameter (not zero please)
n_t="1"           #### Final time step
n_p="10"          #### Number of particles

##MAC
if [ "$machine" == "0" ]; then
### set input.90
cp input_to_edit.f90 input.f90
sed -i "" "s/dist_flag/$dist_flag/g"   ./input.f90
sed -i "" "s/fluid_flag/$fluid_flag/g" ./input.f90
sed -i "" "s/vap_flag/$vap_flag/g"     ./input.f90
sed -i "" "s/temp_flag/$temp_flag/g"   ./input.f90
sed -i "" "s/dump/$dump/g"             ./input.f90
sed -i "" "s/n_t/$n_t/g"               ./input.f90
### copy input in paraview
cp input.f90 ./paraview/
### set module.f90 (main code)
cp module_to_edit.f90 module.f90
sed -i "" "s/n_pppppppp/$n_p/g"        ./module.f90
### set module.f90 (paraview)
cd paraview
cp module_to_edit.f90 module.f90
sed -i "" "s/n_pppppppp/$n_p/g"        ./module.f90
cd ..
fi

##UNIX
if [ "$machine" == "1" ]; then
### set input.90
cp input_to_edit.f90 input.f90
sed -i "s/dist_flag/$dist_flag/g"   ./input.f90
sed -i "s/fluid_flag/$fluid_flag/g" ./input.f90
sed -i "s/vap_flag/$vap_flag/g"     ./input.f90
sed -i "s/temp_flag/$temp_flag/g"   ./input.f90
sed -i "s/dump/$dump/g"             ./input.f90
sed -i "s/n_t/$n_t/g"               ./input.f90
### copy input in paraview
cp input.f90 /paraview/input.f90
### set module.f90 (main code)
cp module_to_edit.f90 module.f90
sed -i "s/n_pppppppp/$n_p/g"        ./module.f90
### set module.f90 (paraview)
cd paraview
cp module_to_edit.f90 module.f90
sed -i "s/n_pppppppp/$n_p/g"        ./module.f90
cd ..
fi

## check parameters
if [[ "$dump" == "0" || "$n_t" == "0" || "$n_p" == "0" ]]; then
echo "WTF! Wrong parameters"
exit 0
fi

## START COMPILING
rm sneeco
rm *.o
rm *.mod
rm -rf results
mkdir results
gfortran -c  module.f90
gfortran -c -o main.o main.f90
gfortran -c -o droplets_dist.o droplets_dist.f90
gfortran -c -o droplets_ic.o droplets_ic.f90
gfortran -c -o read_input.o read_input.f90
gfortran -c -o vaporization.o vaporization.f90
gfortran -c -o tracking.o tracking.f90
gfortran -c -o fluid_vel.o fluid_vel.f90
gfortran -c -ffree-line-length-none -o write_output.o write_output.f90
gfortran -O3 -Wall -o sneeco main.o droplets_dist.o droplets_ic.o module.o read_input.o vaporization.o tracking.o fluid_vel.o write_output.o
./sneeco
rm *.o
rm *.mod
