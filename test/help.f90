program fancy
use, intrinsic :: iso_fortran_env, only : stderr=>ERROR_UNIT,stdin=>INPUT_UNIT,stdout=>OUTPUT_UNIT
use M_attr, only : attr, attr_update, attr_mode
implicit none
integer :: i

character(len=256),parameter ::   help_list_nodash(*)=[character(len=256) :: &
!'<clear>', &
'<E><w><b><bo>F</bo>ortran <bo>P</bo>ackage <bo>M</bo>anager:</b>', &
'<E><w>                                                                        ', &
'<E><w><bo>USAGE: <r><un>fpm</un></r><w> [ <r><un>SUBCOMMAND</un></r> <w>[<m>SUBCOMMAND_OPTIONS</m><w>] ]|&
&<bo>[<g>--list</g><w>|<g>--help</g><w>|<g>--version</g><w>]', &
'<E><w>                                                                        ', &
'<E><w> where <r><un><bo>SUBCOMMAND</bo></un></r> <w>is commonly one of &
&<bo><g>new</g><w>|<g>build</g><w>|<g>run</g><w>|<g>test</g></bo> <w>but may be any of', &
'<E><w>                                                                        ', &
'<E><w>  <bo><g>build</g></bo>     <w>Compile the package placing results in the "build" directory', &
'<E><w>  <bo><g>help</g></bo>      <w>Display help                                                ', &
'<E><w>  <bo><g>list</g></bo>      <w>Display this list of subcommand descriptions                ', &
'<E><w>  <bo><g>new</g></bo>       <w>Create a new Fortran package directory with sample files    ', &
'<E><w>  <bo><g>run</g></bo>       <w>Run the local package application programs                  ', &
'<E><w>  <bo><g>test</g></bo>      <w>Run the test programs                                       ', &
'<E><w>  <bo><g>update</g></bo>    <w>Update and manage project dependencies                      ', &
'<E><w>  <bo><g>install</g></bo>   <w>Install project                                             ', &
'<E><w>                                                                        ', &
'<E><w> <bo>Enter "<r><un>fpm</un></r> <g>--list</g><w></bo>" for a brief list of subcommand options. Enter', &
'<E><w> "<bo><r><un>fpm</un></r> <g>--help</g></bo><w>" or &
&"<bo><r><un>fpm</un> <un>SUBCOMMAND</un></r> <g>--help</g><w></bo>" for detailed descriptions.', &
'<E><w>                                                                        ', &
'<E><w> <bo>Note:</bo> color mode is controlled by the environment variable FPM_COLOR. The', &
'<E><w>       set of allowable values is {<g><bo>always,never,auto</bo></g><w>}. The default is "<g><bo>auto</bo></g><w>". ', &
'<E><w> ']


character(len=256),parameter ::   help_list_dash(*) = [character(len=256) :: &
!'<clear>', &
'<E><w><b><bo>F</bo>ortran </bo>P</bo>ackage <bo>M</bo>anager:</b>', &
'<E><w>                                                           ', &
'<E><w> <bo><g>build</g><w> [<g>--compiler</g> <m>COMPILER_NAME</m><w>] &
&[<g>--profile</g> <m>PROF</m><w>] [<g>--flag</g> <m>FFLAGS</m><w>] [<g>--list</g><w>]', &
'<E><w>                                                           ', &
'<E><w> <bo><g>help</g><w> [<r><un>NAME(s)</un></r><w>]                       ', &
'<E><w>                                                           ', &
'<E><w> <bo><g>new</g><w> <r><un>NAME</un></r><w> [[<g>--lib</g><w>|<g>--src</g><w>] [<g>--app</g><w>] &
&[<g>--test</g><w>] [<g>--example</g><w>]]|', &
'<E><w> <bo>         [<g>--full</g><w>|<g>--bare</g><w>][<g>--backfill</g><w>]', &
'<E><w>                                                           ', &
'<E><w> <bo><g>update</g><w> <w>[<r><un>NAME(s)</un></r><w>] [<g>--fetch-only</g><w>] [<g>--clean</g><w>] [<g>--verbose</g><w>]', &
'<E><w>                                                           ', &
'<E><w> <bo><g>list</g><w> [<g>--list</g><w>]', &
'<E><w>                                                           ', &
'<E><w> <bo><g>run</g><w>  [[<g>--target</g><w>] <r><un>NAME(s)</un></r> <w>[<g>--example</g><w>]&
&[<g>--profile</g><w> <m>PROF</m><w>] [<g>--flag</g><w> <m>FFLAGS</m><w>] [<g>--all</g><w>]', &
'<E><w> <bo>     [<g>--runner</g><w> <m>"CMD"</m><w>] [<g>--compiler</g><w> <m>COMPILER_NAME</m><w>] &
&[<g>--list</g><w>] [-- <m>ARGS</m><w>]', &
'<E><w>                                                           ', &
'<E><w> <bo><g>test</g><w> [[<g>--target</g><w>] <r><un>NAME(s)</un></r><w>] [<g>--profile</g><w> <m>PROF</m><w>] &
&[<g>--flag</g><w> <m>FFLAGS</m><w>] [<g>--runner</g><w> <m>"CMD"</m><w>]', &
'<E><w> <bo>     [<g>--list</g><w>] [<g>--compiler</g><w> <m>COMPILER_NAME</m><w>] [-- <m>ARGS</m><w>]', &
'<E><w>                                                           ', &
'<E><w> <bo><g>install</g><w> [<g>--profile</g><w> <m>PROF</m>] [<g>--flag</g><w> <m>FFLAGS</m>] &
&[<g>--no-rebuild</g><w>] [<g>--prefix</g><w> <m>PATH</m><w>] ', &
'<E><w> <bo>        <w>[<m>OPTIONS</m><w>]', &
'<E><w> ']


! shows a limitation if periods are replaced with spaces the CHAR= option does not
! count the colored blanks so if no text after the blanks too much padding is appended to the line
! need to count last character with a background attribute or something different
!nvfortran bug!character(len=*),parameter :: text(*)= [character(len=132) :: &
character(len=*),parameter :: text(22)= [character(len=132) :: &
'<E><e> <end>                                               ',&
'<E><e>        <C>                                   </W><E><end>',&
'<E><e>        <C>      LLL        </C><bo><w> F</bo>ortran </w></E><C>        <c></bo><end></C><E>',&
'<E><e>        <C>     LL LL        </C><bo><w> P</bo>ackage </w></E><C>       <c></bo><end></C><E>',&
'<E><e>        <C>     LL            </C><bo><w> M</bo>anager </w></E><C>      <c></bo><end></C><E>',&
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
'<E><e>                                                 <end>',&
'<E><bo><b>Program:</b><w>     fpm(1)                                     ',&
'<E><bo><b>Description:</b><w> package manager and build system for Fortran',&
'<E><bo><b>Version:</b><w>     0.3.0, alpha                               ',&
'<E><bo><b>License:</b><w>     MIT                                        ',&
'<E><bo><b>Home Page:</b><w>   https://github.com/fortran-lang/fpm        ']
   call attr_mode(manner='color')

   write(*,'(a)')(attr(trim(help_list_nodash(i)),chars=80),i=1,size(help_list_nodash))
   call paws()

   write(*,'(a)')(attr(trim(help_list_dash(i)),chars=80),i=1,size(help_list_dash))
   call paws()

   ! add custom keywords
   call attr_mode(manner='plain')
   call attr_update('end','.',' ')
   write(*,'(a)')(attr(trim(text(i)),chars=80),i=1,size(text))
   call paws()

   call attr_mode(manner='color')
   call attr_update('end','.',char(0))
   write(*,'(a)')(attr(trim(text(i)),chars=80),i=1,size(text))
   call paws()
contains

subroutine paws()
character(len=1) :: letter
integer :: ios
   write(stdout,'(a)',advance='no',iostat=ios)'Enter [RETURN] to continue ...'
   read(*,'(a)',iostat=ios)letter
   write(stdout,'(a)')attr('<clear>')
   flush(unit=stdout,iostat=ios)

end subroutine paws

end program fancy
