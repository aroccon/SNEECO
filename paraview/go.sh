rm make_vtk
rm *.o
rm *.mod
rm -rf output
mkdir output
gfortran -c  module.f90
gfortran -c -o main.o main.f90
gfortran -c -o read_output.o read_output.f90
gfortran -c -o write_vtk.o write_vtk.f90
gfortran -o make_vtk main.o module.o read_output.o write_vtk.o -O3 -Wall
./make_vtk
rm *.o
rm *.mod
