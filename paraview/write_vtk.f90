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

write(99,*) '# vtk DataFile Version 3.0'
write(99,*) 'Unstructured grid legacy vtk file with point scalar data'
write(99,*) 'ASCII'
write(99,*) 'DATASET UNSTRUCTURED_GRID'
write(99,*) 'POINTS', n_p, 'double'
!write(66) trim(buffer)
do i=1,n_p
 write(99,*) x(i),y(i),0d0
enddo

!buffer='CELL_TYPES'//str4//lf
!write(66) trim(buffer)
!do i=1,part_number
! write(66) 1 ! cell type 1, VTK_VERTEX
!enddo

!buffer='POINT_DATA '//str4//lf
!write(66) trim(buffer)
!buffer='SCALARS position integer 1'//lf
!write(66) trim(buffer)
!buffer='LOOKUP_TABLE default'//lf
!write(66) trim(buffer)
!do i=1,part_number
! write(66) 1 ! empty buffer
!enddo

!if(partvelflag.eq.1)then
! buffer='VECTORS velocity float'//lf
! write(66) trim(buffer)
! do i=1,part_number!
!  write(66) real(upar(i,1)),real(upar(i,2)),real(upar(i,3))
! enddo
!endif




close(99)

return
end
