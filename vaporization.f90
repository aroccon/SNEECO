subroutine vaporization(t)

use parameters
use droplets
integer :: i,t
double precision :: yv, yvs

!! no vaporization
if (vap_flag.eq.0) then
  d=d
end if

!! vaporization model
if (vap_flag.eq.1) then
  print*,'Computing vaporization - step',t
  do i=1,n_p
    sh_zero=2d0+0.552*(rep(i)**05d0)*(sc**(1d0/3d0))
    nu_zero=2d0+0.552*(rep(i)**05d0)*(pr**(1d0/3d0))
    !! computing the vapor molar fraction
    pws=133d0*exp(20.386-5132d0/t_d(i)) !!pressure saturation in pascal
    xvs=pws/p_zero
    yvs=xvs/(xvs + (1d0 - xvs)*(wg/wl))
    bm=(yvs-y_inf)/(1d0-y_vs)
    fm=((1d0+bm)**0.7d0)*log(1d0+bm)/bm
    bt=cp_vapor*(t_inf-t_d(i))/latent_heat
    ft=((1d0+bt)**0.7d0)*log(1d0+bt)/bt
    !! sherwood and nusselt computed
    sh=2+(sh_zero-2d0)/fm
    nu=2+(nu_zero-2d0)/ft
    !if (i.eq.1) print*,'rep',rep(i),'bm',bm,'bt',bt,'ft',ft,'sh0',sh_zero,'nu0',nu_zero,'sh',sh,'nu',nu
    m(i)=rho_l*pi/6d0*d(i)**3d0
    taup=rho_l*d(i)**2d0/(18*mu_g)
    rhsm=-(1d0/3d0)*(m(i)/taup)*(sh/sc)*log(1d0+bm)
    m_new(i)=m(i) + rhsm*dt
    !if (i.eq.1) print*,'rhsm',rhsm
  enddo

  do i=1,n_p
    !update mass
    m(i)=m_new(i)
    !update diameter
    d_new=((6d0*m(i))/(rho_l*pi))**(1d0/3d0)
    if (d_new/d_0(i).gt. 0.3d0) then
      d(i)=d_new           !!! dropleta above threeshold
    else
      d(i)=0.3d0*d_0(i)    !!! dropleta below threeshold -- stop evaporation
    end if
  end do

  m_new(:)=0d0
end if

return
end
