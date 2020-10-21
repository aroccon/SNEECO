module parameters
  implicit none
  double precision, parameter :: pi = 3.1415927
  integer, parameter :: n_x=1000,n_y=1000
  integer, parameter :: n_p=1000
  integer :: dist_flag,fluid_flag,vap_flag,temp_flag,dump,n_t
  double precision :: dt,rho_g,mu_g,rho_l,g
  double precision :: u_0,y_0,x_0
  double precision :: sc,pr,le
  double precision :: diff_vap_air,kappa_g,p_zero,y_inf,min_d
  double precision :: t_ref,latent_heat,vapor_gas_constant,t_inf,wg,wl
  double precision :: cp_air,cp_vapor,cp_water
end module parameters

module droplets
  use parameters
  double precision :: d(n_p),d_0(n_p),d_new(n_p)
  double precision :: taup(n_p),sh(n_p),nu(n_p)
  double precision :: temp(n_p),rhstemp(n_p)
  double precision :: m(n_p),m_new(n_p),rhsm(n_p)
  double precision :: rep(n_p)
  double precision :: x(n_p),y(n_p)
  double precision :: u(n_p),v(n_p)
  double precision :: x_new(n_p),y_new(n_p)
  double precision :: u_new(n_p),v_new(n_p)
  double precision :: temp_new(n_p)
  double precision :: rhsx(n_p),rhsy(n_p)
  double precision :: u_f(n_p),v_f(n_p)
  double precision :: bm(n_p),bt(n_p),bt_old(n_p)
  double precision :: u_r(n_x,n_y),v_r(n_x,n_y)
end module droplets
