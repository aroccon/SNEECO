subroutine write_vtk(t)

use parameters
use droplets
integer :: t
character(len=8) :: step
character(len=40) :: file_name

print*,'Creating .vtk file for step',t

!Creating file name
write(step,'(I8.8)') t
file_name='outparaview_'//step//'.vtk'

!open file
open(unit=99,file='output/'//file_name,form='formatted',status='new',action='write')
!! Writting to be implemented
close(99)

return
end
