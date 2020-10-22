subroutine fluid_vel(t)

use parameters
use droplets
implicit none
integer :: i,j,t,n,l
integer :: im,ip,jm,jp
double precision :: x_r(n_x),y_r(n_y),b(n_x),u_c(n_x),rb(n_x,n_y)
double precision :: lx,ly,dx,dy
double precision :: d_inlet,alpha,beta
double precision :: xm,xp,ym,yp,pl(2,2)
double precision :: ustencil(2,2),vstencil(2,2)

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
    u_c(i)=u_0*(7.2d0/6.2d0)*6.2d0*((x_r(i)+x_0+d_inlet)/d_inlet)**(-1d0)
    b(i)=beta*(x_r(i)+d_inlet)
  end do
  !!
  rb(:,:)=0d0
  do i=1,n_x
    do j=1,n_y
      rb(i,j)=(y_r(j)-y_0)/b(i)
      u_r(i,j)=u_c(i)*exp(-rb(i,j)**2d0)
      v_r(i,j)=abs(alpha*u_c(i)*(1d0-exp(-rb(i,j)**2d0)-(beta/alpha)*(-rb(i,j)**2d0)*exp(-rb(i,j)**2d0))/rb(i,j))
    end do
  end do
  !! top hat filter + center line
  do i=1,n_x
    do j=1,n_y
      if (abs(y_r(j)-y_0) .ge. 0.16d0*(x_r(i)+d_inlet)) then
         u_r(i,j)=0d0
         v_r(i,j)=0d0
      end if
    end do
  end do
  do i=1,n_x
    do j=1,n_y
      u_r(i,j)=x_r(i)
      v_r(i,j)=y_r(j)
    end do
  end do
  call write_output_flow
end if

!! flow field already initialized
!! loop on the particles
do i=1,n_p
  !! check position and then compute im (minus),ip (plus)
  if ( (x(i).ge.0d0) .and. (x(i).le.lx)) then
    im=floor(x(i)/dx)+1
    ip=im+1
    ! debug print*,'im',im,'ip',ip
  end if
  if ( (y(i).ge.0d0) .and. (y(i).le.ly)) then
    jm=floor(y(i)/dy)+1
    jp=jm+1
    !debug print*,'jm',jm,'jp',jp
  end if
  !!! node locations
  xm=(im-1)*dx
  xp=(ip-1)*dx
  ym=(jm-1)*dy
  yp=(jp-1)*dy
  print*,'xm',xm,'xp',xp,'ym',ym,'yp',yp
  !!! computing lagrangina polynomials
  ustencil(1,1)=u_r(im,jm)
  ustencil(1,2)=u_r(im,jp)
  ustencil(2,1)=u_r(ip,jm)
  ustencil(2,2)=u_r(ip,jp)
  vstencil(1,1)=v_r(im,jm)
  vstencil(1,2)=v_r(im,jp)
  vstencil(2,1)=v_r(ip,jm)
  vstencil(2,2)=v_r(ip,jp)
  !print*,'ust(1,1)',ustencil(1,1),'br',u_r(1,750)
  !print*,'ust(1,2)',ustencil(1,2),'br',u_r(1,751)
  !print*,'ust(2,1)',ustencil(2,1),'br',u_r(2,750)
  !print*,'ust(2,2)',ustencil(2,2),'br',u_r(2,751)
  pl(:,:)=0d0
  pl(1,1)=(x(i)-xp)/(xm-xp)
  pl(1,2)=(x(i)-xm)/(xp-xm)
  pl(2,1)=(y(i)-yp)/(ym-yp)
  pl(2,2)=(y(i)-ym)/(yp-ym)
  u_f(i)=0d0
  v_f(i)=0d0
  do n=1,2
    do l=1,2
      u_f(i)=u_f(i) + ustencil(n,l)*pl(1,n)*pl(2,l)
      v_f(i)=v_f(i) + vstencil(n,l)*pl(1,n)*pl(2,l)
    end do
  end do
  print*,'u_f',u_f(i),'v_f',v_f(i)
end do


return
end
















subroutine write_output_flow

use parameters
use droplets
implicit none
character(len=40) :: file_name
integer :: i,j


file_name='output_u.dat'

open(unit=99,file='results/'//file_name,form='formatted',status='new',action='write')
do i=1,n_x
 write(99,'(*(es16.8e3))')(u_r(i,j),j=1,n_y) !! not matrix?
end do
close(99)


file_name='output_v.dat'

open(unit=99,file='results/'//file_name,form='formatted',status='new',action='write')
do i=1,n_x
 write(99,'(*(es16.8e3))')(v_r(i,j),j=1,n_y) !! not matrix?
end do
close(99)

return
end
