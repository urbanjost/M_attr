program demo_attr
! read stdin and run it through M_attr::attr to display color
use M_attr,  only : attr, attr_update
implicit none
character(len=1024)          :: line
character(len=:),allocatable :: expanded
integer                      :: icount
integer                      :: ios
   line=''
   call attr_update('Z',char(27)//'[1m')
   icount=command_argument_count() ! get number of arguments
   ! if command arguments use those instead of reading stdin
   ! example: light '<clear><B><w><bo><CSI>12;36f Good Morning! '
   if(icount.gt.0)then
      call args()
   else
      do 
         read(*,'(a)',iostat=ios)line
         expanded = attr(trim(line))
         write(*,'(a)') expanded
         if(ios.ne.0)exit
      enddo
      write(*,'(a)',advance='no') attr('<reset>')
   endif
contains
subroutine args()
implicit none
integer                      :: i
integer                      :: istat
integer                      :: argument_length
character(len=:),allocatable :: argument
   do i=1,icount
       call get_command_argument(number=i,length=argument_length)
       ! allocate string array big enough to hold command line argument
       if(allocated(argument))deallocate(argument)
       allocate(character(len=argument_length) :: argument)
       ! read the argument 
       call get_command_argument(i, argument,status=istat)
       expanded = attr(trim(argument))
       write(*,'(a)') expanded
   enddo
   end subroutine args
end program demo_attr
