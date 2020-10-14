subroutine fluid_vel

use parameters
use droplets
integer i

!case 0 - no fluid velocity
if (fluid_flag.eq.0) then
  do i=1,n_p
    u_f(i)=0.d0
    v_f(i)=0.d0
  end do
end if

!case 1 - Jet?
!if (fluid_flag.eq.1) then
!end if

return
end
