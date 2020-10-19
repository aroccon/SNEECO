subroutine droplets_dist

use parameters
use droplets
integer, parameter :: n_c=100
double precision :: coef,mu,sigma,f_norm
double precision :: d_c(n_c),dist_an(n_c)
double precision, allocatable :: d1(:)
integer :: n_tot,n_drop(n_c)
integer :: i,j,k

if (dist_flag.eq.0) then
  print*,'Log-Normal distribution'
  !Parameters of the distribution
  coef=9.e-3
  mu=log(1.5e-5)
  sigma=0.5

  ! Generating the initial classes
  d_c(1)=1.e-6
  do i=2,n_c
    d_c(i)=d_c(i-1) + 1.e-6
  end do
  do i=1,n_c
      dist_an(i)=coef/d_c(i)*(exp(-(log(d_c(i)) - mu)**2)/(2.0*sigma**2))
  enddo

  !Normalizzazione (i.e. somma=1)
  f_norm=sum(dist_an)
  dist_an=dist_an/f_norm

  !Sampling
  do i=1,n_c
    n_drop(i)=anint(dist_an(i)*n_p)
    !print*,'n_drop',n_drop(i)
  enddo
  n_tot=sum(n_drop)
  allocate(d1(n_tot))
  d1=0d0
  k=0
  do i=1,n_c-1
    a = d_c(i)
    b = d_c(i+1)
    do j=1,n_drop(i)
      k=k+1
      call random_number(d(k))
      d1(k)=(b-a)*d1(k) + a
    end do
  end do

  !print*,'n_tot',n_tot

!  do i=1,n_tot
!    print*,'d1(i)',d1(i)
  !enddo

  !! remove or add partcles to match n_p
  !! Case 1 Matched, no actions
  if (n_tot .eq. n_p) then
    d=d1
  end if

  !! Case 2 n_tot is smaller
  if (n_tot .lt. n_p) then
    !print*,'case 2'
    do i=1,n_tot
      d(i)=d1(i)
    end do
    do i=n_tot+1,n_p
      a=d_c(1)
      b=d_c(n_c)
      !print*,'a',a,'b',b
      call random_number(d(i))
      d(i)=(b-a)*d(i) + a
    end do
  end if

  !! Case 3 n_tot is larger
  if (n_tot .gt. n_p) then
    do i=1,n_p
      d(i)=d1(i)
    end do
  end if

  deallocate(d1)

  call bubble_sort

end if

!!backup of the initial distribution (for vaporization)
do i=1,n_p
  d_0(i)=d(i)
end do

!do i=1,n_p
!  print*,'d(i)',d(i)
!enddo

  print*,'Droplets distribution set'

return
end








subroutine bubble_sort
use droplets
double precision :: tmp
integer :: i,j
logical :: swapped

  do j = size(d)-1, 1, -1
    swapped = .false.
    do i = 1, j
      if (d(i) > d(i+1)) then
        tmp = d(i)
        d(i) = d(i+1)
        d(i+1) = tmp
        swapped = .true.
      end if
    end do
    if (.not. swapped) exit
  end do
  return
end
