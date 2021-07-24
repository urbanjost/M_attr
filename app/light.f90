program demo_attr
! read stdin and run it through M_attr::attr to display color
use M_attr,  only : attr, attr_update
implicit none
character(len=1024)          :: line
character(len=:),allocatable :: expanded
integer :: ios
   line=''
   call attr_update('Z',char(27)//'[1m')
   do 
      read(*,'(a)',iostat=ios)line
      expanded = attr(trim(line))
      write(*,'(a)') expanded
      if(ios.ne.0)exit
   enddo
   write(*,'(a)',advance='no') attr('<reset>')
end program demo_attr
