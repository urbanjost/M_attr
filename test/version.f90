program version
use M_attr, only : attr
! shows a limitation if periods are replaced with spaces the CHAR= option does not
! count the colored blanks so if no text after the blanks too much padding is appended to the line
! need to count last character with a background attribute or something different
implicit none
integer :: i
character(len=*),parameter :: text(*)= [character(len=132) :: &
'<E>                                                                            ',&
'<E>                                                                            ',&
'<E>                                                                            ',&
'<E>                 <R>...</R><E>    <r><bo>F<w>ortran                          ',&
'<E>                <R>..</R><E> <R>..</R><E>    <g><bo>P<w>ackage              ',&
'<E>                <R>..</R><E>    <b><bo>M<w>anager                           ',&
'<E>              <R>.....</R><E>                                               ',&
'<E>                <R>..</R><E>                                                ',&
'<E>                <R>..</R><E>               <B>.....</B><E> <B>...</B><E>                                ',&
'<E>                <R>..</R><E>     <G>......</G><E>     <B>..</B><E>  <B>.</B><E>  <B>..</B><E>           ',&
'<E>                <R>..</R><E>    <G>..</G><E>     <G>.</G><E>    <B>..</B><E>  <B>.</B><E>  <B>..</B><E> ',&
'<E>                <R>..</R><E>    <G>..</G><E>     <G>.</G><E>    <B>..</B><E>  <B>.</B><E>  <B>..</B><E> ',&
'<E>                <R>..</R><E>    <G>.......</G><E>     <B>..</B><E>  <B>.</B><E>  <B>..</B><E>           ',&
'<E>                      <G>..</G><E>                                          ',&
'<E>                      <G>..</G><E>                                          ',&
'<E>                      <G>..</G><E>                                          ',&
'<E>                                                                            ',&
'<E><g>Version:</g><w>     0.3.0, alpha                                         ',&
'<E><g>Program:</g><w>     fpm(1)                                               ',&
'<E><g>Description:</g><w> A Fortran package manager and build system           ',&
'<E><g>Home Page:</g><w>   https://github.com/fortran-lang/fpm                  ',&
'<E><g>License:</g><w>     MIT                                                  ',&
'<E><g>OS Type:</g><w>     Linux']
write(*,'(a)')(attr(trim(text(i)),chars=80),i=1,size(text))
end program version
