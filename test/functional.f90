program mode
   use M_attr, only : attr, attr_mode
   implicit none
        call printme('color')
        call printme('plain')
        call printme('raw')
   contains
   subroutine printme(mymode)
   character(len=*),intent(in) :: mymode
      call attr_mode(mymode)
      write(*,'(a)')mymode
      write(*,'(*(g0))',advance='no')attr('red:BLUE:bold'),'Hello!', &
       & attr('/BLUE'),' Well, this is boring without a nice background color.',attr('reset')
      write(*,'(*(g0))',advance='yes')' Back to a normal write statement.'
   end subroutine printme
end program mode
