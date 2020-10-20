subroutine vaporization(t)

use parameters
use droplets
integer :: i,t


print*,'Computing vaporization - step',t
if (temp_flag.eq.1)  print*,'Computing temperature - step ',t

do i=1,n_p
  call compute_sh_nu(i,t)
  m(i)=rho_l*pi/6d0*d(i)**3d0
  rhsm(i)=-(1d0/3d0)*(m(i)/taup(i))*(sh(i)/sc)*log(1d0+bm(i))
  m_new(i)=m(i) + rhsm(i)*dt
  m(i)=m_new(i)
  d_new(i)=((6d0*m(i))/(rho_l*pi))**(1d0/3d0)
  if ((d_new(i)/d_0(i)).lt.min_d) then
    d(i)=min_d*d_0(i)           !!! dropleta below threeshold
    rhsm(i)=0d0                 !!! for temperature update
  else
    d(i)=d_new(i)   !!! droplets below threeshold -- stop evaporation
  end if
  if (temp_flag.eq.1) then
    rhstemp(i)=(rhsm(i)/(m(i)*cp_water))*(latent_heat-cp_vapor*(t_inf-temp(i))/bt(i))
    temp_new(i)=temp(i) + rhstemp(i)*dt
    temp(i)=temp_new(i)
  end if
end do

return
end

!if (i.eq.n_p) print*,'bt',bt(i),'btold(i)',bt_old(i),'sh',sh(i),'nu',nu(i),'only-latent rhst',rhstemp(i),'temp',temp(i)
!if (i.eq.n_p) print*,'bt',bt(i),'btold(i)',bt_old(i),'sh',sh(i),'nu',nu(i),'with temperature rhst',rhstemp(i),'temp',temp(i)
!if (i.eq.n_p) print*,'bt',bt(i),'btold(i)',bt_old(i),'sh',sh(i),'nu',nu(i),'overall rhst',rhstemp(i),'temp',temp(i)
!if (i.eq.1) print*,'d_new/d_0',d(i)/d_0(i),'rhsm(i)',rhsm(i),'sh',sh(i),'nu',nu(i),'rhst',rhstemp(i),'temp',temp(i)
!if (i.eq.1) print*,'bt',bt(i),'btold(i)',bt_old(i),'sh',sh(i),'nu',nu(i),(i),'temp',temp(i)
!if (i.eq.1) print*,'sh',sh(i),'nu',nu(i)
!if (i.eq.1) print*,'d_new/d_0',d_new(i)/d_0(i)







subroutine compute_sh_nu(i,t)

use parameters
use droplets
double precision :: sh_zero,nu_zero
double precision :: p_ws,x_vs,y_vs
double precision :: fm,ft,phi
integer :: i,t

!!mass part
sh_zero=2d0+0.552*(rep(i)**0.5d0)*(sc**(1d0/3d0))
!! computing the vapor molar fraction
p_ws=133d0*exp(20.386-5132d0/temp(i)) !!pressure saturation in pascal
x_vs=p_ws/p_zero
y_vs=x_vs/(x_vs + (1d0 - x_vs)*(wg/wl))
bm(i)=(y_vs-y_inf)/(1d0-y_vs)
fm=((1d0+bm(i))**0.7d0)*log(1d0+bm(i))/bm(i)
sh(i)=2d0+(sh_zero-2d0)/fm

!!thermal part
nu_zero=2d0+0.552*(rep(i)**0.5d0)*(pr**(1d0/3d0))
if (t .eq. 1) then
  bt_old(i)=cp_vapor*(t_inf-temp(i))/latent_heat
else
  bt_old(i)=bt(i)
end if
!print*,'bt_old',bt_old(i)
ft=((1d0+bt_old(i))**0.7d0)*log(1d0+bt_old(i))/bt_old(i)
nu(i)=2d0+(nu_zero-2d0)/ft
phi=(cp_water/cp_air)*(sh(i)/nu(i))*(1d0/le)
bt(i)=(1d0+bm(i))**phi-1d0



return
end
