subroutine fluid_vel(t)

use parameters
use droplets
integer i,t
double precision :: x_r(n_x),y_r(n_y),b(n_x),u_c(n_x),rb(n_x,n_y)
double precision :: lx,ly
double precision :: d_inlet,alpha,beta

alpha=0.057d0
beta=0.114d0
d_inlet=0.02


!! generate initial flow field (only 1st iteration)
if (t.eq.1) then
  !! grid defintion
  lx=2d0
  ly=2d0
  dx=lx/(n_x-1)
  dy=ly/(n_y-1)
  x_r(1)=0d0
  y_r(1)=0d0
  do i=2,n_x
    x_r(i)=x_r(i-1)+dx
  end do
  do i=2,n_y
    y_r(i)=y_r(i-1)+dy
  end do
  !!! start flow field init
  !!! center line velocity
  x_0=6.2d0*d_inlet
  do i=1,n_x
    u_c(i)=u_0*6.2*((x_r(i)+x_0)/d_inlet)**(-1d0)
    b(i)=beta*x(i)
  end do
  !!
  do i=1,n_x
    do j=1,n_y
      rb(i,j)=(y(j)-y_0)/b(i)
      if (i.eq.1) rb(i,j)=0d0
      u_r(i,j)=u_c(i)*exp(-rb(i,j)**2d0)
      v_r(i,j)=abs(alpha*u_c(i)*(1-exp(-rb(i,j)**2d0)-(beta/alpha)*(rb(i,j)**2d0)*exp(-rb(i,j)**2d0))/rb(i,j))
    end do
  end do
  !! top hat filter + center line
  do i=1,n_x
    do j=1,n_y
        if (abs(y(j)-y_0) .gt. 0.16d0*x(i)) then
            u_r(i,j)=0d0
            v_r(i,j)=0d0
        end if
        if (isnan(u_r(i,j))) u_r(i,j)=0d0
        if (isnan(v_r(i,j))) v_r(i,j)=0d0
    end do
  end do
  call write_output_flow
end if
!! check for nan?

!! no init required


return
end
















subroutine write_output_flow

use parameters
use droplets
character(len=40) :: file_name


file_name='output_u.dat'

open(unit=99,file='results/'//file_name,form='formatted',status='new',action='write')
do i=1,n_x
 write(99, '(2x,es16.8)')(u_r(i,j),j=1,n_y) !! not matrix?
end do
close(99)


file_name='output_v.dat'

open(unit=99,file='results/'//file_name,form='formatted',status='new',action='write')
do i=1,n_x
 write(99, '(2x,es16.8)')(v_r(i,j),j=1,n_y) !! not matrix?
end do
close(99)

return
end
