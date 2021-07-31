module M_testsuite_M_attr
use, intrinsic :: iso_fortran_env, only : standard_in=>input_unit, standard_out=>output_unit, std_error=>error_unit
use M_verify
use M_attr
implicit none
character(len=*),parameter :: options=' -section 3 -library libGPF -filename `pwd`/m_attr.FF &
& -documentation y -ufpp   y -ccall  n -archive  GPF.a '
contains
!TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
subroutine test_suite_m_attr()
   call test_attr()
   call test_attr_mode()
   call test_attr_update()
   call test_advice()
end subroutine test_suite_m_attr
!TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
subroutine test_attr()
logical :: allpassed
integer :: i
   call unit_check_start('attr',' -description display text with attributes'//OPTIONS)
   allpassed = .true.
   call attr_mode('color')
   allpassed=allpassed  .and.  test('<red>red',          char(27)//'[31mred'//char(27)//'[0m')
   allpassed=allpassed  .and.  test('<green>green',      char(27)//'[32mgreen'//char(27)//'[0m')
   allpassed=allpassed  .and.  test('<blue>blue',        char(27)//'[34mblue'//char(27)//'[0m')
   allpassed=allpassed  .and.  test('<cyan>cyan',        char(27)//'[36mcyan'//char(27)//'[0m')
   allpassed=allpassed  .and.  test('<magenta>magenta',  char(27)//'[35mmagenta'//char(27)//'[0m')
   allpassed=allpassed  .and.  test('<yellow>yellow',    char(27)//'[33myellow'//char(27)//'[0m')
   allpassed=allpassed  .and.  test('<ebony>ebony',      char(27)//'[30mebony'//char(27)//'[0m')
   allpassed=allpassed  .and.  test('<white>white',      char(27)//'[37mwhite'//char(27)//'[0m')
   allpassed=allpassed  .and.  test('<RED>RED',          char(27)//'[41mRED'//char(27)//'[0m')
   allpassed=allpassed  .and.  test('<GREEN>GREEN',      char(27)//'[42mGREEN'//char(27)//'[0m')
   allpassed=allpassed  .and.  test('<BLUE>BLUE',        char(27)//'[44mBLUE'//char(27)//'[0m')
   allpassed=allpassed  .and.  test('<CYAN>CYAN',        char(27)//'[46mCYAN'//char(27)//'[0m')
   allpassed=allpassed  .and.  test('<MAGENTA>MAGENTA',  char(27)//'[45mMAGENTA'//char(27)//'[0m')
   allpassed=allpassed  .and.  test('<YELLOW>YELLOW',    char(27)//'[43mYELLOW'//char(27)//'[0m')
   allpassed=allpassed  .and.  test('<EBONY>EBONY',      char(27)//'[40mEBONY'//char(27)//'[0m')
   allpassed=allpassed  .and.  test('<WHITE>WHITE',      char(27)//'[47mWHITE'//char(27)//'[0m')

   call attr_mode('plain')
   allpassed=allpassed  .and.  test('<red>red',          'red')
   allpassed=allpassed  .and.  test('<green>green',      'green')
   allpassed=allpassed  .and.  test('<blue>blue',        'blue')
   allpassed=allpassed  .and.  test('<cyan>cyan',        'cyan')
   allpassed=allpassed  .and.  test('<magenta>magenta',  'magenta')
   allpassed=allpassed  .and.  test('<yellow>yellow',    'yellow')
   allpassed=allpassed  .and.  test('<ebony>ebony',      'ebony')
   allpassed=allpassed  .and.  test('<white>white',      'white')
   allpassed=allpassed  .and.  test('<RED>RED',          'RED')
   allpassed=allpassed  .and.  test('<GREEN>GREEN',      'GREEN')
   allpassed=allpassed  .and.  test('<BLUE>BLUE',        'BLUE')
   allpassed=allpassed  .and.  test('<CYAN>CYAN',        'CYAN')
   allpassed=allpassed  .and.  test('<MAGENTA>MAGENTA',  'MAGENTA')
   allpassed=allpassed  .and.  test('<YELLOW>YELLOW',    'YELLOW')
   allpassed=allpassed  .and.  test('<EBONY>EBONY',      'EBONY')
   allpassed=allpassed  .and.  test('<WHITE>WHITE',      'WHITE')

   call attr_mode('raw')
   allpassed=allpassed  .and.  test('<red>red',          '<red>red')
   allpassed=allpassed  .and.  test('<green>green',      '<green>green')
   allpassed=allpassed  .and.  test('<blue>blue',        '<blue>blue')
   allpassed=allpassed  .and.  test('<cyan>cyan',        '<cyan>cyan')
   allpassed=allpassed  .and.  test('<magenta>magenta',  '<magenta>magenta')
   allpassed=allpassed  .and.  test('<yellow>yellow',    '<yellow>yellow')
   allpassed=allpassed  .and.  test('<ebony>ebony',      '<ebony>ebony')
   allpassed=allpassed  .and.  test('<white>white',      '<white>white')
   allpassed=allpassed  .and.  test('<RED>RED',          '<RED>RED')
   allpassed=allpassed  .and.  test('<GREEN>GREEN',      '<GREEN>GREEN')
   allpassed=allpassed  .and.  test('<BLUE>BLUE',        '<BLUE>BLUE')
   allpassed=allpassed  .and.  test('<CYAN>CYAN',        '<CYAN>CYAN')
   allpassed=allpassed  .and.  test('<MAGENTA>MAGENTA',  '<MAGENTA>MAGENTA')
   allpassed=allpassed  .and.  test('<YELLOW>YELLOW',    '<YELLOW>YELLOW')
   allpassed=allpassed  .and.  test('<EBONY>EBONY',      '<EBONY>EBONY')
   allpassed=allpassed  .and.  test('<WHITE>WHITE',      '<WHITE>WHITE')

   call unit_check('attr',allpassed,msg='')
   call unit_check_done('attr')

   contains

   function test(in, ExpectedResult) result(passed)
      character(len=*),intent(in) :: in
      character(len=*),intent(in) :: ExpectedResult
      logical                     :: Passed
      passed = attr(in).eq.ExpectedResult

      if(passed)then
         write(std_error,*)"Passed on ",in, " converted to ", ExpectedResult
      else
         write(std_error,*)"Failed on ",in, " got ", attr(in), " Expected ",ExpectedResult
      endif

   end function test
end subroutine test_attr
!TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
subroutine test_attr_update()
character(len=:),allocatable :: targetline
   call unit_check_start('attr_update',' '//OPTIONS)
   !call unit_check('attr_update',targetline.eq.'a b ab baaa aaCCCC CCCC CCCC a a a aa aaaaaa','example of using RANGE',targetline)
   if(unit_check_level.gt.0)then
   endif
   call unit_check_done('attr_update')
end subroutine test_attr_update
!TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
subroutine test_attr_mode()
character(len=*),parameter :: in='<B><bo>Hello!</bo></B> <G><y>Hello Again!</y></G>'
character(len=*),parameter :: expected_color= &
   & char(27)//'[44m'//char(27)//'[1mHello!'// &
   & char(27)//'[22m'//char(27)//'[49m '//char(27)//'[42m'//char(27)//'[33mHello Again!'// &
   & char(27)//'[39m'//char(27)//'[49m'//char(27)//'[0m'
character(len=*),parameter :: expected_plain='Hello! Hello Again!'
   call unit_check_start('attr_mode',' '//OPTIONS)
   call attr_mode(manner='color')
   call unit_check('attr_mode',attr(in).eq.expected_color,'color')
   call attr_mode(manner='plain')
   call unit_check('attr_mode',attr(in).eq.expected_plain,'plain')
   call attr_mode(manner='raw')
   call unit_check('attr_mode',attr(in).eq.in,'raw')
   call unit_check_done('attr_mode')
end subroutine test_attr_mode
!TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
subroutine test_advice()
   call unit_check_start('advice',' '//OPTIONS)
   !call unit_check('advice',targetline.eq.'a b ab baaa aaCCCC CCCC CCCC a a a aa aaaaaa','example of using RANGE',targetline)
   call unit_check_done('advice')
end subroutine test_advice
!TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
end module M_testsuite_M_attr

program runtest
use M_msg
use M_verify, only : unit_check_command, unit_check_keep_going, unit_check_level
use M_testsuite_M_attr
   unit_check_command=''
   unit_check_keep_going=.true.
   unit_check_level=0
   call test_suite_M_attr()
end program runtest
!TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
