!----------------------------------------------------------------------------------------
program dots ! @(#) random dots on screen till ctrl-C
use M_attr, only : attr
    implicit none
    integer          :: x, y
    integer          :: z
    character(len=1) :: p
    integer          :: fg, bg
    integer          :: pair
    real             :: r
    real             :: c
    integer          :: ierr
    character(len=10),parameter :: colors(8)=[character(len=10) :: 'RED','GREEN','BLUE','CYAN','MAGENTA','YELLOW','BLACK','WHITE']
    fg = 8
    bg = 7
    r=80
    c=24
    INFINITE: do
        x=int((c*ranf())+1)
        y=int((r*ranf())+1)
        if (ranf() > 0.9) then
           p="*"
        else
           p=" "
        endif
        write(*,'(*(g0))',advance='no')attr('<CSI>',reset=.false.),x,';',y,'f',p
        z=min(8,int(ranf()*8+1))
        write(*,'(a)',advance='no')attr('<'//trim(colors(z))//'>',reset=.false.)
    enddo INFINITE
CONTAINS
!----------------------------------------------------------------------------------------
FUNCTION ranf() result (r)
   IMPLICIT NONE
   REAL :: r
   LOGICAL,SAVE :: already_run=.TRUE.
   IF(.NOT.already_run)THEN
      CALL init_random_seed_by_clock()
      already_run=.TRUE.
   ENDIF
   CALL random_number(r)
END FUNCTION ranf
!----------------------------------------------------------------------------------------
SUBROUTINE init_random_seed_by_clock()
   implicit none
   INTEGER :: i, n, clock
   INTEGER, DIMENSION(:), ALLOCATABLE :: seed
   CALL RANDOM_SEED(size = n)
   ALLOCATE(seed(n))
   CALL SYSTEM_CLOCK(COUNT=clock)
   seed = clock + 37 * (/ (i - 1, i = 1, n) /)
   CALL RANDOM_SEED(PUT = seed)
   DEALLOCATE(seed)
END SUBROUTINE init_random_seed_by_clock
!----------------------------------------------------------------------------------------
END PROGRAM dots
