subroutine droplets_ic

use parameters
use droplets
integer i

print*,'Setting droplets initial conditions'

do i=1,n_p
  x(i)=0.d0
  y(i)=1.5d0
  u(i)=5.d0
  v(i)=0d0 !debug
  temp(i)=273d0 + 35d0
end do

return
end
