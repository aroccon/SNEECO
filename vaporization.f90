subroutine vaporization

use parameters
use droplets

!! no vaporization
if (vap_flag.eq.0) then
  d=d
end if

!! vaporization model
if (vap_flag.eq.1) then
  !!!!d=d
end if

return
end
