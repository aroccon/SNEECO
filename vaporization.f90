subroutine vaporization(t)

use parameters
use droplets
integer :: i,t

!! no vaporization
if (vap_flag.eq.0) then
  d=d
end if

!! vaporization model
if (vap_flag.eq.1) then
  print*,'Computing vaporization - step',t
  do i=1,n_p
  enddo
end if

return
end
