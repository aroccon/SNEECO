subroutine write_output(t,time)

use parameters
use droplets
integer :: t
double precision :: time
character(len=8) :: step
character(len=40) :: file_name

print*,'Writting output of step',t

!Creating file name
write(step,'(I8.8)') t
file_name='output_'//step//'.dat'

!open file
open(unit=99,file='results/'//file_name,form='formatted',status='new',action='write')

write(99,*) '% Time.............: ',time
write(99,*) '% Distribution.....: ',dist_flag
write(99,*) '% Fluid flag.......: ',fluid_flag
write(99,*) '% Vaporization flag: ',vap_flag
write(99,*) '% Temperature flag.: ',temp_flag
write(99,*) '%    ID      Diameter         X position        Y position        X velocity       Y velocity           Mass            Temperature'
do i=1,n_p
  write(99,'(i8,(7(2x,es16.8)))') i,d(i),x(i),y(i),u(i),v(i),m(i),temp(i)
enddo
close(99)

return
end
