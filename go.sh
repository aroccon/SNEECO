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
gfortran -c -o write_output.o write_output.f90
gfortran -o sneeco main.o droplets_dist.o droplets_ic.o module.o read_input.o vaporization.o tracking.o fluid_vel.o write_output.o
./sneeco
rm *.o
rm *.mod
