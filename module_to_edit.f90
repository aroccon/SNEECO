module parameters
  implicit none
  integer, parameter :: n_p=n_pppppppp
  integer :: dist_flag,fluid_flag,vap_flag,dump,n_t
  double precision :: dt,rho_g,mu_g,rho_l,cd,g
  double precision :: sc,pr,diff_vap_air,cp_air,kappa
end module parameters

module droplets
  use parameters
  double precision :: d(n_p)
  double precision :: rep(n_p)
  double precision :: x(n_p),y(n_p)
  double precision :: u(n_p),v(n_p)
  double precision :: x_new(n_p),y_new(n_p)
  double precision :: u_new(n_p),v_new(n_p)
  double precision :: u_f(n_p),v_f(n_p)
end module droplets
