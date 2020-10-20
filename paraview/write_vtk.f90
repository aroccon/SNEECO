subroutine write_vtk(t)

use parameters
use droplets
integer :: t
character(len=8) :: step
character(len=40) :: file_name
character(len=80) :: buffer
character(len=10) :: lf
character(len=16) :: str4


lf=achar(10)
print*,'Creating .vtk file for step',t
write(str4(1:16),'(i16)') n_p
write(step,'(I8.8)') t
file_name='outparaview_'//step//'.vtk'

!open file
open(unit=99,file='output/'//file_name,form='unformatted',status='new',access='stream',convert='big_endian')

! write head of file
buffer='# vtk DataFile Version 3.0'//lf
write(99) trim(buffer)
buffer='Particle data'//lf
write(99) trim(buffer)
buffer='BINARY'//lf
write(99) trim(buffer)
buffer='DATASET UNSTRUCTURED_GRID'//lf
write(99) trim(buffer)
buffer='POINTS '//str4//' float'//lf
write(99) trim(buffer)
do i=1,n_p
 write(99) real(x(i)),real(y(i)),real(0d0)
enddo


buffer='CELL_TYPES'//str4//lf
write(99) trim(buffer)
do i=1,n_p
 write(99) 1 ! cell type 1, VTK_VERTEX
enddo

buffer='POINT_DATA '//str4//lf
write(99) trim(buffer)
buffer='SCALARS position integer 1'//lf
write(99) trim(buffer)
buffer='LOOKUP_TABLE default'//lf
write(99) trim(buffer)
do i=1,n_p
 write(99) 1 ! empty buffer
enddo

!if(partvelflag.eq.1)then
! buffer='VECTORS velocity float'//lf
! write(66) trim(buffer)
! do i=1,part_number
!  write(66) real(upar(i,1)),real(upar(i,2)),real(upar(i,3))
! enddo
!endif

buffer=lf
write(99) trim(buffer)
close(99,status='keep')


return
end
