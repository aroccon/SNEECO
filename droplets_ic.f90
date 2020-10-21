subroutine droplets_ic

use parameters
use droplets
integer i

print*,'Setting droplets initial conditions'

do i=1,n_p
  x(i)=0.d0
  y(i)=y_0
  u(i)=u_0
  v(i)=0d0
  temp(i)=273d0 + 35d0
end do

return
end
