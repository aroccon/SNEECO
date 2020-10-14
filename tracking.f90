subroutine tracking

use parameters
use droplets
double precision :: cd,rep,g
double precision :: rhsx,rhsy
integer i

g=9.81

!! new position
do i=1,n_p
  x_new(i)=x(i) + u(i)*dt
  y_new(i)=x(i) + v(i)*dt
enddo

!print*,'d(1)',d(1)
!! new velocity
do i=1,n_p
  rep=rho_g*d(i)*sqrt((u(i)-u_f(i))**2 + (v(i)-v_f(i))**2)/mu_g
!  if (abs(rep) .lt. 0.00001d0) cd=0d0
!  if ((rep .lt. 1000d0) .and. (rep .gt. 0.0001d0)) cd=24d0/rep*(1d0 + 0.15d0*rep**(0.687d0))
  if (rep .lt. 1000d0) cd=24d0/rep*(1d0 + 0.00d0*rep**(0.687d0))
  if (rep .gt. 1000d0) cd=0.424
  !rhsx= 3*cd*(rho_g/rho_l)*(1d0/d(i))*abs(u_f(i)-u(i))*(u_f(i)-u(i))
  rhsx= cd*(rho_g/rho_l)*(1d0/d(i))*abs(u_f(i)-u(i))*(u_f(i)-u(i))
  rhsy= cd*(rho_g/rho_l)*(1d0/d(i))*abs(v_f(i)-v(i))*(v_f(i)-v(i)) - (1d0-rho_g/rho_l)*g
  u_new(i)=u(i) + rhsx*dt
  v_new(i)=v(i) + rhsy*dt
  !if (i.eq.1) print*,'d',d(1)
  if (i.eq.1) print*,'rep',rep,'u_new',u_new(i),'rhsx',rhsx,'cd',cd
  if (i.eq.1) print*,'rep',rep,'v_new',v_new(i),'rhsy',rhsy,'cd',cd
enddo

do i=1,n_p
  x(i)=x_new(i)
  y(i)=y_new(i)
  u(i)=u_new(i)
  v(i)=v_new(i)
end do

x_new(:)=0d0
y_new(:)=0d0
u_new(:)=0d0
v_new(:)=0d0

return
end
