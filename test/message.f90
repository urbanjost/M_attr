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
      write(*,'(a)')attr('<ERROR>Woa is nigh.')
      write(*,'(a)')attr('<WARNING>The night is young.')
      write(*,'(a)')attr('<INFO>It is monday')
   end subroutine printme
end program mode
