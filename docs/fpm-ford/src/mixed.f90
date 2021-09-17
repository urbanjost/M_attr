          program demo_M_attrape
          use M_attr, only : attr, attr_mode, attr_update
             write(*,'(a)') attr('<clear>TEST DEFAULTS:')
             call printstuff()

             write(*,'(a)') attr('TEST MANNER=PLAIN:')
             call attr_mode(manner='plain')
             call printstuff()

             write(*,'(a)') attr('TEST MANNER=RAW:')
             call attr_mode(manner='raw')
             call printstuff()

             write(*,'(a)') attr('TEST MANNER=VT102:')
             call attr_mode(manner='vt102')
             call printstuff()

             write(*,'(a)') attr('TEST ADDING A CUSTOM SEQUENCE:')
             call attr_update('blink',char(27)//'[5m')
             call attr_update('/blink',char(27)//'[25m')
             write(*,'(a)') attr('<blink>Items for Friday</blink>')

          contains
          subroutine printstuff()

             write(*,'(a)') attr('<r>RED</r>,<g>GREEN</g>,<b>BLUE</b>')
             write(*,'(a)') attr('<c>CYAN</c>,<m>MAGENTA</g>,<y>YELLOW</y>')
             write(*,'(a)') attr('<w>WHITE</w> and <e>EBONY</e>')

             write(*,'(a)') attr('Adding <bo>bold</bo>')
             write(*,'(a)') attr('<bo><r>RED</r>,<g>GREEN</g>,<b>BLUE</b></bo>')
             write(*,'(a)') attr('<bo><c>CYAN</c>,<m>MAGENTA</g>,<y>YELLOW</y></bo>')
             write(*,'(a)') attr('<bo><w>WHITE</w> and <e>EBONY</e></bo>')

             write(*,'(a)') attr('Adding <ul>underline</ul>')
             write(*,'(a)') attr('<bo><ul><r>RED</r>,<g>GREEN</g>,<b>BLUE</b></ul></bo>')
             write(*,'(a)') attr('<bo><ul><c>CYAN</c>,<m>MAGENTA</g>,<y>YELLOW</y></ul></bo>')
             write(*,'(a)') attr('<bo><ul><w>WHITE</w> and <e>EBONY</e></ul></bo>')

             write(*,'(a)') attr('Adding <ul>italic</ul>')
             write(*,'(a)') attr('<bo><ul><it><r>RED</r>,<g>GREEN</g>,<b>BLUE</b></it></ul></bo>')
             write(*,'(a)') attr('<bo><ul><it><c>CYAN</c>,<m>MAGENTA</g>,<y>YELLOW</it></y></ul></bo>')
             write(*,'(a)') attr('<bo><ul><it><w>WHITE</w> and <e>EBONY</e></ul></bo>')

             write(*,'(a)') attr('Adding <in>inverse</in>')
             write(*,'(a)') attr('<in><bo><ul><it><r>RED</r>,<g>GREEN</g>,<b>BLUE</b></it></ul></bo></in>')
             write(*,'(a)') attr('<in><bo><ul><it><c>CYAN</c>,<m>MAGENTA</g>,<y>YELLOW</it></y></ul></bo></in>')
             write(*,'(a)') attr('<in><bo><ul><it><w>WHITE</w> and <e>EBONY</e></ul></bo></in>')
       end subroutine printstuff 
       end program demo_M_attrape
