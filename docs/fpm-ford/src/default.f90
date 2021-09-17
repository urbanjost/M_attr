          program demo_M_attr
          use M_attr, only : attr, attr_mode, attr_update
             write(*,'(a)') attr('TEST MANNER=DEFAULT:')
          
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
       end program demo_M_attr
