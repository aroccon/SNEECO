module parameters
  implicit none
  double precision, parameter :: pi = 3.1415927
  integer, parameter :: n_p=n_pppppppp
  integer :: dist_flag,fluid_flag,vap_flag,dump,n_t
  double precision :: dt,rho_g,mu_g,rho_l,cd,g
  double precision :: sc,pr,diff_vap_air,cp_air,cp_vapor,kappa
  double precision :: nu_zero,sh_zero,nu,sh
  double precision :: t_ref,latent_heat,vapor_gas_constant,t_inf
  double precision :: ft,fm,p_zero
  double precision :: xvs,wg,wl,taup,rhsm,dnew
end module parameters

module droplets
  use parameters
  double precision :: d(n_p)
  double precision :: d_0(n_p)
  double precision :: t_d(n_p)
  double precision :: m(n_p)
  double precision :: rep(n_p)
  double precision :: x(n_p),y(n_p)
  double precision :: u(n_p),v(n_p)
  double precision :: m_new(n_p)
  double precision :: x_new(n_p),y_new(n_p)
  double precision :: u_new(n_p),v_new(n_p)
  double precision :: u_f(n_p),v_f(n_p)
end module droplets
