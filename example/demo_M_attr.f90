           program demo_M_attr
           use M_attr, only : attr, attr_mode
           implicit none
           character(len=256) :: line
           character(len=*),parameter :: f='( &
           &"   <bo><w><G> GREAT: </G></w>&
           &The new value <Y><b>",f8.4,1x,"</b></Y> is in range"&
           &)'
           real :: value
              write(*,'(a)')&
              &attr('   <r><W><bo> ERROR: </W>red text on a white background</y>')

              value=3.4567
              write(line,fmt=f) value
              write(*,'(a)')attr(trim(line))

              ! write same string as plain text
              call attr_mode(manner='plain')
              write(*,'(a)')attr(trim(line))

           end program demo_M_attr
