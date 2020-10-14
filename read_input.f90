subroutine read_input

use parameters

open(unit=66,file='input.f90',form='formatted',status='old',action='read')

read(66,'(i8)') dist_flag
read(66,'(i8)') fluid_flag
read(66,'(i8)') vap_flag
read(66,'(i8)') dump

close(66)

return
end
