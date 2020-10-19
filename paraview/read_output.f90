subroutine read_output(t)

use parameters
use droplets
integer :: t,id
character(len=8) :: step
character(len=40) :: file_name

print*,'Reading output of step     ',t

!Creating file name
write(step,'(I8.8)') t
file_name='output_'//step//'.dat'

!open file
open(unit=99,file='../results/'//file_name,form='formatted',status='old',action='read')
! ignore first 5 lines
read(99,*)
read(99,*)
read(99,*)
read(99,*)
read(99,*)
read(99.*)
!!! results read
do i=1,n_p
  read(99,'(i8,(5(2x,es16.8)))') id,d(i),x(i),y(i),u(i),v(i),m(i),temp(i)
enddo

close(99)

return
end
