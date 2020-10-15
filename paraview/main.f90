program make_vtk

integer :: dummy,dump,n_t,n_p

!!Read dumping frequency
open(unit=64,file='../input.f90',form='formatted',status='old',action='read')
read(64,'(i8)') dummy
read(64,'(i8)') dummy
read(64,'(i8)') dummy
read(64,'(i8)') dump
read(64,'(i8)') n_t
read(64,'(i8)') n_p
close(64)

!!Read output from code

do t=0,dump,n_t

  call read_output(t)

  call write_vtk

end do

end program
