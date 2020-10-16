module parameters
  implicit none
  double precision, parameter :: pi = 3.1415927
  integer, parameter :: n_p=n_pppppppp
  integer :: dist_flag,fluid_flag,vap_flag,dump,n_t
  double precision :: dt,rho_g,mu_g,rho_l,g
  double precision :: sc,pr
  double precision :: diff_vap_air,cp_air,cp_vapor,kappa,p_zero,y_inf
  double precision :: t_ref,latent_heat,vapor_gas_constant,t_inf,wg,wl
end module parameters

module droplets
  use parameters
  double precision :: d(n_p),d_0(n_p),d_new(n_p)
  double precision :: taup(n_p),sh(n_p),nu(n_p)
  double precision :: t_d(n_p)
  double precision :: m(n_p),m_new(n_p),rhsm(n_p)
  double precision :: rep(n_p)
  double precision :: x(n_p),y(n_p)
  double precision :: u(n_p),v(n_p)
  double precision :: x_new(n_p),y_new(n_p)
  double precision :: u_new(n_p),v_new(n_p)
  double precision :: rhsx(n_p),rhsy(n_p)
  double precision :: u_f(n_p),v_f(n_p)
end module droplets
