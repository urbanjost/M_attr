           program demo_attr_mode
           use M_attr, only : attr, attr_mode
           implicit none
           character(len=1024) :: line
           real :: value

             value=3.4567
             if( (value>0.0) .and. (value<100.0))then
               write(line,fmt='("&
              &<w><G>GREAT</G></w>: The value <Y><b>",f8.4,"</b></Y> is in range &
              &")')value
             else
               write(line,fmt='("&
              &<R><e>ERROR</e></R>:The new value <Y><b>",g0,"</b></Y> is out of range&
              & ")')value
             endif

             write(*,'(a)')attr(trim(line))

             call attr_mode(manner='plain') ! write as plain text
             write(*,'(a)')attr(trim(line))
             call attr_mode(manner='raw')   ! write as-is
             write(*,'(a)')attr(trim(line))
             call attr_mode(manner='ansi')  ! return to default mode
             write(*,'(a)')attr(trim(line))

              end program demo_attr_mode
