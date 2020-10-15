program sneeco

use parameters
use droplets
integer :: i,j,k,t
double precision :: time

!call cpu_time(t_start)

print*,"SNEECO - LPT of C19 droplets"

call read_input

call droplets_dist

call droplets_ic

!! LPT parameters
dt=0.000001
rho_g=1.164d0   !! at T_r
mu_g=1.872e-5
rho_l=1000
g=9.81

if (vap_flag .eq. 1) then
  !! 1/3 rule, properties evaluated at T_r=t_s + 1/3* (T_inf - T_s)
  !! T_inf=20 *** T_s=35 *** T_r=30
  diff_vap_air=2.4e-5
  cp_air=1007d0
  cp_vapor=1867d0
  kappa=0.02588d0
  t_ref=273d0+30d0
  t_inf=273d0+20d0
  latent_heat=2429000d0 !! J/kg
  vapor_gas_constant=461d0 !! J / K Kg
  !! molar mass of vapor and water
  wg=0.02897d0 !! kg/mol
  wl=0.01801d0 !! kg/mol
  p_zero=1e5 !! Pascal
  y_inf=0.007333 !! vapor mass fraction RH50% and 20C
  sc=mu_g/(rho_g*diff_vap_air)
  print*,'Schmidt number:', sc
  pr=mu_g*cp_air/kappa
  print*,'Prandtl number:', pr
  !! Backup of d_0
  d_0=d
endif

!! Writting initial fields
time=0d0
call write_output(0,time)

!!Start temporal loop
print*,'Start temporal loop'
do t=1,n_t

  time=time+dt

  call fluid_vel

  call tracking(t)

  call vaporization(t)

  if (mod(t,dump).eq.0) call write_output(t,time)

end do

end program
