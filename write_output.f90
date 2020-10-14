subroutine write_output(t)

use parameters
use droplets
integer :: t
character(len=8) :: time
character(len=40) :: file_name

print*,'Writting output of step',t

!Creating file name
write(time,'(I8.8)') t
file_name='output_'//time//'.dat'

open(unit=66,file='results/'//file_name,form='formatted',status='new',action='write')

!read(66,'(i8)') dist_flag
!read(66,'(i8)') fluid_flag
!read(66,'(i8)') vap_flag
!read(66,'(i8)') dump

!close(66)


return
end
