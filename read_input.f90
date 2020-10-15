subroutine read_input

use parameters
integer :: dummy

open(unit=64,file='input.f90',form='formatted',status='old',action='read')

read(64,*) dist_flag
read(64,*) fluid_flag
read(64,*) vap_flag
read(64,*) dump
read(64,*) n_t

close(64)

return
end
