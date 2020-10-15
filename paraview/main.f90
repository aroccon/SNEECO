program make_vtk

use parameters
use droplets
integer :: t
integer :: dummy

!!Read dumping frequency
open(unit=64,file='../input.f90',form='formatted',status='old',action='read')
read(64,*) dummy
read(64,*) dummy
read(64,*) dummy
read(64,*) dump
read(64,*) n_t
close(64)

!!Read output from code
!! Start temporal loop
do t=0,dump,n_t

  call read_output(t)

  call write_vtk(t)

end do

end program
