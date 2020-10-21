subroutine fluid_vel(t)

use parameters
use droplets
integer i,t
double precision :: x_r(n_x),y_r(n_y)
double precision :: lx,ly


!! generate initial flow field (only 1st iteration)
if (t.eq.1) then
  lx=2d0
  ly=2d0
  dx=lx/(n_x-1)
  dy=ly/(n_y-1)
  x_r(1)=0d0
  y_r(1)=0d0
  do i=2,n_x
    x_r(i)=x_r(i-1)+dx
    print*,'x_r(i)',x_r(i)
  end do
  do i=2,n_y
    y_r(i)=y_r(i-1)+dy
    print*,'y_r(i)',x_r(i)
  end do
end if



return
end
