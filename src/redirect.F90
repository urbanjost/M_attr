program roots
use, intrinsic :: iso_fortran_env, only : stdin=>input_unit, stdout=>output_unit, stderr=>error_unit
use M_attr, only : attr, attr_mode, attr_update
! Calculate and print the roots of a quadratic formula even if they are complex
implicit none
integer,parameter               :: dp=kind(0.0d0)
real(kind=dp)                   :: a, b, c, discriminant
real(kind=dp)                   :: x1, x2, x ! Real roots of the equation
real(kind=dp)                   :: x_real    ! Real part of complex root of the equation
REAL(kind=dp)                   :: x_complex ! Imaginary part of complex root of the equation
character(len=256)              :: message
integer                         :: ios
character(len=1)                :: paws
character(len=1024)             :: buffer
character(len=*),parameter      :: numbers='("<B><w><bo>   ",*("(",g0.8,",",g0.8,")":,1x))'
character(len=:),allocatable    :: TERM

   if(system_isatty(stdout))then ! ISATTY() is an extension, but found in Intel, GNU, PGI, ... compiler
      call attr_mode('color')
   else
      call attr_mode('plain')
   endif

   TERM=system_getenv('TERM','vt102') ! perhaps change or add strings based on terminal type
   select case(TERM)
   case('xterm')
      call attr_update('mono',attr( '<esc>]11;black<bel><esc>]10;white<bel>' )) ! change default bg and fg
   case('screen')
   end select

   INFINITE: do
      ! clear screen, set attributes and print messages
      call text("<reset><clear>")
      call text("For the quadratic equation <m>A</m><g>*x**2 +<m>B</m><g>*x + <m>C</m> ")
      write(stdout,'(*(a))',advance='no') &
      & attr('<B><w><bo>',chars=80), &
      & char(13),&
      & attr('<B><g><bo>enter coefficients <m>A,B,C</m><g>:<y><gt><ul>',&
      & reset=.false.,chars=80)
      read(stdin,*,iostat=ios,iomsg=message)a,b,c
      write(stdout,'(a)',advance='no')attr('<reset>')
      if(ios.ne.0)then
         write(stdout,*)
         write(stdout,'(*(g0))')ios,' ',trim(message)
         rewind(unit=stdin,iostat=ios)
         backspace(unit=stdin,iostat=ios)
      else
         ! Given the equation "A*X**2 + B*X + C = 0"
         ! Use the quadratic formula to determine the root values of the equation.
         ! prompt for new value

         call text()
         call text('Given the equation')
         call text()
         write(buffer,'(*(g0.8))') '<B><w><bo>   ',a,'<m>*X**2</m><w> + ',b,'<m>*X</m><w> + ',c,' = 0'
         call text(buffer)
         call text()

         discriminant = b**2 - 4*a*c

         if (a.eq.0)then
            call text('<ERROR> <m>If <m>a</m><g> is zero this is a linear, not quadratic equation')
         elseif ( discriminant>0 ) then
            call text('the <m>roots</m><g> (ie. "x intercepts") are <m>real<m><g> so the parabola ')
            call text('crosses the x-axis at <m>two points</m><g>:')
            call text()
            x1 = ( -b + sqrt(discriminant)) / (2 * a)
            x2 = ( -b - sqrt(discriminant)) / (2 * a)
            write(buffer,numbers)x1,0.0d0
            call text(buffer)
            write(buffer,numbers)x2,0.0d0
            call text(buffer)
            call text()
         elseif ( discriminant==0 ) then

            call text('the <m>roots</m><g> (ie. "x intercepts") are repeated <m>(real and equal)</m><g>')
            call text('so the parabola just touches the x-axis at:')
            call text()
            if(b.ne.0)then
               x = (-b) / (2 * a)
            else
               x = 0.0d0
            endif
            write(buffer,numbers)x,0.0d0
            call text(buffer)
            call text()
         else
            call text('the <m>roots</m><g>(ie. "x intercepts")  are <m>complex</m><g>:')
            x_real     = (-b)/(2 * a)
            x_complex  = sqrt (abs(discriminant)) / (2 * a)
            call text()
            WRITE(buffer,'(a,*("(",g0.8,", +i",g0.8,")",:,1x))') '<B><w><bo>   ', x_real,x_complex
            call text(buffer)
            WRITE(buffer,'(a,*("(",g0.8,", -i",g0.8,")",:,1x))') '<B><w><bo>   ', x_real,x_complex
            call text(buffer)
            call text()
         endif
         call text('with')
         call text()
         write(buffer,'(g0,*(g0.8,1x))')"<B><w><bo>   <m>discriminate</m><w> = ", discriminant
         call text(buffer)
         call text()
      endif
      write(stdout,'(*(g0))',advance='no')attr('<B><e>press <g>return</g><e> to continue, "<g>q</g><e>" to quit:',chars=79)
      read(stdin,advance='yes',iostat=ios,fmt='(a)',iomsg=message)paws
      if(paws.ne.'')exit INFINITE
   enddo INFINITE
contains
subroutine text(string)
character(len=*),intent(in),optional :: string
   if(present(string))then
      write(stdout,'(*(g0))') attr('<B><g><bo>'//trim(string),chars=80)
   else
      write(stdout,'(*(g0))') attr('<B><g><bo>',chars=80)
   endif
end subroutine text
!>  call compiler-specific ISATTY() function or return .FALSE.
#undef ISATTY

#ifdef __INTEL_COMPILER
    function system_isatty(lun)
    use IFPORT
    integer,intent(in) :: lun
    logical :: system_isatty
       system_isatty=isatty(lun)
    end function system_isatty
#define ISATTY
#endif

#ifdef __NVCOMPILER_MAJOR__X
    ! __NVCOMPILER_MAJOR__ __NVCOMPILER_MINOR__ __NVCOMPILER_PATCHLEVEL__
    function system_isatty(lun)
    use DFPORT
    integer,intent(in) :: lun
    logical :: system_isatty
       system_isatty=isatty(lun)
    end function system_isatty
#define ISATTY
#endif

#ifdef __GFORTRAN__
    function system_isatty(lun)
    integer,intent(in) :: lun
    logical :: system_isatty
       system_isatty=isatty(lun)
    end function system_isatty
#define ISATTY
#endif
#ifndef ISATTY
    function system_isatty(lun)
    integer,intent(in) :: lun
    logical :: system_isatty
       system_isatty=.false.
    end function system_isatty
#define ISATTY
#endif
function system_getenv(name,default) result(value)

!$@(#) M_system::system_getenv(3f): call get_environment_variable as a function with a default value(3f)

character(len=*),intent(in)          :: name
character(len=*),intent(in),optional :: default
integer                              :: howbig
integer                              :: stat
character(len=:),allocatable         :: value

   if(NAME.ne.'')then
      call get_environment_variable(name, length=howbig, status=stat, trim_name=.true.)  ! get length required to hold value
      if(howbig.ne.0)then
         select case (stat)
         case (1)     ! print *, NAME, " is not defined in the environment. Strange..."
            value=''
         case (2)     ! print *, "This processor doesn't support environment variables. Boooh!"
            value=''
         case default ! make string to hold value of sufficient size and get value
            if(allocated(value))deallocate(value)
            allocate(character(len=max(howbig,1)) :: VALUE)
            call get_environment_variable(name,value,status=stat,trim_name=.true.)
            if(stat.ne.0)VALUE=''
         end select
      else
         value=''
      endif
   else
      value=''
   endif
   if(value.eq.''.and.present(default))value=default

end function system_getenv
END PROGRAM roots
