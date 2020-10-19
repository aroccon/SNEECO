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
read(64,*) dummy
read(64,*) dump
read(64,*) n_t
close(64)

!!print*,'dump',dump
!!print*,'n_t',n_t
!!Read output from code
!! Start temporal loop
do t=0,n_t,dump

  call read_output(t)

  call write_vtk(t)

end do

end program
