program version
use M_attr, only : attr, attr_update, attr_mode
! shows a limitation if periods are replaced with spaces the CHAR= option does not
! count the colored blanks so if no text after the blanks too much padding is appended to the line
! need to count last character with a background attribute or something different
implicit none
integer :: i
!nvfortran bug!character(len=*),parameter :: text(*)= [character(len=132) :: &
character(len=*),parameter :: text(23)= [character(len=132) :: &
'<E><e>                                                     ',&
'<E><e>        <C>                                   </W><E><end>',&
'<E><e>        <C>      LLL        </C><E> <bo><w>F</bo>ortran   </w></E><C>       <E><e></bo><end>',&
'<E><e>        <C>     LL LL       </C><E>  <bo><w>P</bo>ackage  </w></E><C>       <E><e></bo><end>',&
'<E><e>        <C>     LL          </C><E>   <bo><w>M</bo>anager </w></E><C>       <E><e></bo><end>',&
'<E><e>        <C>   LLLLLL                          <E><end>',&
'<E><e>        <C>     LL                            <E><end>',&
'<E><e>        <C>     LL               LLLLL LLL    <E><end>',&
'<E><e>        <C>     LL     LLLLLL     LL  L  LL   <E><end>',&
'<E><e>        <C>     LL    LL     L    LL  L  LL   <E><end>',&
'<E><e>        <C>     LL    LL     L    LL  L  LL   <E><end>',&
'<E><e>        <C>     LL    LLLLLLL     LL  L  LL   <E><end>',&
'<E><e>        <C>           LL                      <E><end>',&
'<E><e>        <C>           LL                      <E><end>',&
'<E><e>        <C>           LL                      <E><end>',&
'<E><e>        <C>                                   <E><end>',&
'<E><e>                                                     ',&
'<E><bo><b>Program:</b><w>     fpm(1)                                     ',&
'<E><bo><b>Description:</b><w> A Fortran package manager and build system ',&
'<E><bo><b>Version:</b><w>     0.3.0, alpha                               ',&
'<E><bo><b>License:</b><w>     MIT                                        ',&
'<E><bo><b>Home Page:</b><w>   https://github.com/fortran-lang/fpm        ',&
'<E><bo>']
   ! add custom keywords
   call attr_update('end','.',' ')
   call attr_mode(manner='plain')
   write(*,'(a)')(attr(trim(text(i)),chars=80),i=1,size(text))
   call attr_update('end','.',char(0))
   call attr_mode(manner='color')
   write(*,'(a)')(attr(trim(text(i)),chars=80),i=1,size(text))
end program version
