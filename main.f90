program sneeco

use parameters
use droplets
integer :: i,j,k,t
double precision :: time

!call cpu_time(t_start)

call read_input

call droplets_dist

call droplets_ic

! LPT
dt=0.000001
rho_g=1d0
mu_g=0.00001
rho_l=1000


!!Start temporal loop
time=0d0

print*,'Start temporal loop'
do t=0,n_t

  if (mod(t,dump).eq.0) call write_output(t,time)

  time=time+dt

  call fluid_vel

  call tracking

  call vaporization

end do

end program
