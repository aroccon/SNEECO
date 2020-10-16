module parameters
  implicit none
  integer, parameter :: n_p=100
  integer :: dump,n_t
end module parameters

module droplets
  use parameters
  double precision :: d(n_p)
  double precision :: x(n_p),y(n_p)
  double precision :: u(n_p),v(n_p)
end module droplets
