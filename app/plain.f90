program demo_attr
! read stdin and run it through M_attr::attr to display without color
use M_attr, only : attr, attr_mode
implicit none
character(len=1024) :: line
integer :: ios
   line=''
   call attr_mode(manner='plain')
   do 
      read(*,'(a)',iostat=ios)line
      write(*,'(a)') attr(trim(line))
      if(ios.ne.0)exit
   enddo
   write(*,'(a)',advance='no') attr('<reset>')
end program demo_attr
