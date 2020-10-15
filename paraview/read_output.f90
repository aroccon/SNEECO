subroutine read_output(t)

integer :: t
character(len=8) :: step
character(len=40) :: file_name

print*,'Writting output of step',t

!Creating file name
write(step,'(I8.8)') t
file_name='output_'//step//'.vtk'

!open file
open(unit=99,file='../results/'//file_name,form='formatted',status='old',action='read')
! ignore first 5 lines
read(99,*)
read(99,*)
read(99,*)
read(99,*)
read(99,*)
!!! results read (to be implemented)

close(99)

return
end
