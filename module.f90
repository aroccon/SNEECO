module parameters
  implicit none
  integer, parameter :: n_p=10000
  integer :: dist_flag,fluid_flag,vap_flag,dump
  double precision :: dt,rho_g,mu_g,rho_l
end module parameters

module droplets
  use parameters
  double precision :: d(n_p)
  double precision :: x(n_p),y(n_p)
  double precision :: u(n_p),v(n_p)
  double precision :: x_new(n_p),y_new(n_p)
  double precision :: u_new(n_p),v_new(n_p)
  double precision :: u_f(n_p),v_f(n_p)
end module droplets
