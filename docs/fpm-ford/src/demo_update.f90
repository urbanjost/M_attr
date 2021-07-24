           program demo_update
           use M_attr, only : attr, attr_update
              write(*,'(a)') attr('<clear>TEST CUSTOMIZED:')
              ! add custom keywords
              call attr_update('blink',char(27)//'[5m')
              call attr_update('/blink',char(27)//'[38m')

              write(*,'(a)') attr('<blink>Items for Friday</blink>')

              write(*,'(a)',advance='no') attr('<r>RED</r>,')
              write(*,'(a)',advance='no') attr('<b>BLUE</b>,')
              write(*,'(a)',advance='yes') attr('<g>GREEN</g>')

              ! delete
              call attr_update('r')
              call attr_update('/r')
              ! replace
              call attr_update('b','<<<<')
              call attr_update('/b','>>>>')
              write(*,'(a)',advance='no') attr('<r>RED</r>,')
              write(*,'(a)',advance='no') attr('<b>BLUE</b>,')
              write(*,'(a)',advance='yes') attr('<g>GREEN</g>')

           end program demo_update
