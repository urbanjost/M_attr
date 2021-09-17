module M_testsuite_M_attr
use, intrinsic :: iso_fortran_env, only : standard_in=>input_unit, standard_out=>output_unit, std_error=>error_unit
use M_verify
use M_attr
implicit none
character(len=*),parameter :: options=' -section 3 -library libGPF -filename `pwd`/m_attr.FF &
& -documentation y -ufpp   y -ccall  n -archive  GPF.a '
character(len=1),parameter :: esc=char(27)
contains
!TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
subroutine test_suite_m_attr()
   call test_attr()
   call test_attr_mode()
   call test_attr_update()
   call test_alert()
end subroutine test_suite_m_attr
!TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
subroutine test_attr()
logical :: allpassed
   call unit_check_start('attr',' -description display text with attributes'//OPTIONS)
   allpassed = .true.
   call attr_mode('color')
   allpassed=allpassed  .and.  test('<red>red',          esc//'[31mred'//esc//'[0m')
   allpassed=allpassed  .and.  test('<green>green',      esc//'[32mgreen'//esc//'[0m')
   allpassed=allpassed  .and.  test('<blue>blue',        esc//'[34mblue'//esc//'[0m')
   allpassed=allpassed  .and.  test('<cyan>cyan',        esc//'[36mcyan'//esc//'[0m')
   allpassed=allpassed  .and.  test('<magenta>magenta',  esc//'[35mmagenta'//esc//'[0m')
   allpassed=allpassed  .and.  test('<yellow>yellow',    esc//'[33myellow'//esc//'[0m')
   allpassed=allpassed  .and.  test('<ebony>ebony',      esc//'[30mebony'//esc//'[0m')
   allpassed=allpassed  .and.  test('<white>white',      esc//'[37mwhite'//esc//'[0m')
   allpassed=allpassed  .and.  test('<RED>RED',          esc//'[41mRED'//esc//'[0m')
   allpassed=allpassed  .and.  test('<GREEN>GREEN',      esc//'[42mGREEN'//esc//'[0m')
   allpassed=allpassed  .and.  test('<BLUE>BLUE',        esc//'[44mBLUE'//esc//'[0m')
   allpassed=allpassed  .and.  test('<CYAN>CYAN',        esc//'[46mCYAN'//esc//'[0m')
   allpassed=allpassed  .and.  test('<MAGENTA>MAGENTA',  esc//'[45mMAGENTA'//esc//'[0m')
   allpassed=allpassed  .and.  test('<YELLOW>YELLOW',    esc//'[43mYELLOW'//esc//'[0m')
   allpassed=allpassed  .and.  test('<EBONY>EBONY',      esc//'[40mEBONY'//esc//'[0m')
   allpassed=allpassed  .and.  test('<WHITE>WHITE',      esc//'[47mWHITE'//esc//'[0m')

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

   call unit_check('attr',allpassed,msg='basic colors passed foreground and background')
   call unit_check_done('attr')

   contains

   function test(in, ExpectedResult) result(passed)
      character(len=*),intent(in) :: in
      character(len=*),intent(in) :: ExpectedResult
      logical                     :: Passed
      passed = attr(in).eq.ExpectedResult

      if(.false.)then
      if(passed)then
         write(std_error,*)"Passed on ",in, " converted to ", ExpectedResult
      else
         write(std_error,*)"Failed on ",in, " got ", attr(in), " Expect ",ExpectedResult
      endif
      endif

   end function test
end subroutine test_attr
!TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
subroutine test_attr_update()
character(len=:),allocatable :: in
character(len=:),allocatable :: out
   call unit_check_start('attr_update',' '//OPTIONS)
   if(unit_check_level.gt.0)then
   endif
   call attr_mode(manner='color')
   call attr_update('/b','>>>>')
   call attr_update('b','<<<<')
   call attr_update('blink',esc//'[5m')
   call attr_update('/blink',esc//'[25m')
   call attr_update('mono',attr( '<esc>]11;black<bel><esc>]10;white<bel>' )) ! change default bg and fg
   call attr_update('/r')
   call attr_update('r')

   in=attr('<blink>blink!</blink> stare!')
   out=esc//'[5mblink!'//esc//'[25m stare!'//esc//'[0m'
   call unit_check('attr_update',in.eq.out,'add blink, in=',in,'out=',attr(in),'expect=',out)

   in=attr('<r>red removed</r>')
   out='<r>red removed</r>'
   call unit_check('attr_update',in.eq.out,'in=',in,'out=',attr(in),'expect=',out)

   in=attr('<b>blue replaced</b>')
   out='<<<<blue replaced>>>>'
   call unit_check('attr_update',in.eq.out,'in=',in,'out=',attr(in),'expect=',out)

   call unit_check_done('attr_update')
end subroutine test_attr_update
!TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
subroutine test_attr_mode()
character(len=*),parameter :: in='<B><bo>Hello!</bo></B> <G><y>Hello Again!</y></G>'
character(len=*),parameter :: expected_color= &
   & esc//'[44m'//esc//'[1mHello!'// &
   & esc//'[22m'//esc//'[49m '//esc//'[42m'//esc//'[33mHello Again!'// &
   & esc//'[39m'//esc//'[49m'//esc//'[0m'
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
subroutine test_alert()
   call unit_check_start('alert',' '//OPTIONS)
   !call unit_check('alert',targetline.eq.'a b ab baaa aaCCCC CCCC CCCC a a a aa aaaaaa','example of using RANGE',targetline)
   call unit_check_done('alert')
end subroutine test_alert
!TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
end module M_testsuite_M_attr

program runtest
use M_msg
use M_verify, only : unit_check_command, unit_check_keep_going, unit_check_level, unit_check_stop
use M_testsuite_M_attr
   unit_check_command=''
   unit_check_keep_going=.true.
   unit_check_level=0
   call test_suite_M_attr()
   call unit_check_stop
end program runtest
!TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
