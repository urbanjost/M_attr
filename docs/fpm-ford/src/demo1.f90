program demo_M_attr
use M_attr, only : attr, attr_mode, attr_update
implicit none
character(len=1024) :: line
character(len=:),allocatable :: expanded
integer :: ios
   write(*,'(a)')&
&attr('The most common attributes and their defaults keywords:         '),&
&attr('     colors:                                                    '),&
&attr('       <r>r</r>,         red,       <R>R</R>,  RED              '),&
&attr('       <g>g</g>,         green,     <G>G</G>,  GREEN            '),&
&attr('       <b>b</b>,         blue,      <B>B</B>,  BLUE             '),&
&attr('       <m>m</m>,         magenta,   <M>M</M>,  MAGENTA          '),&
&attr('       <c>c</c>,         cyan,      <C>C</C>,  CYAN             '),&
&attr('       <y>y</y>,         yellow,    <Y>Y</Y>,  YELLOW           '),&
&attr('       <e>e</e>,         ebony,     <E>E</E>,  EBONY            '),&
&attr('       <w>w</w>,         white,     <W>W</W>,  WHITE            '),&
&attr('     attributes:                                                '),&
&attr('       <it>it</it>,        italic                               '),&
&attr('       <bo>bo</bo>,        bold                                 '),&
&attr('       <un>un</un>,        underline                            '),&
&attr('     other:                                                     '),&
&attr('       clear                                                    '),&
&attr('       attr,       escape                                       '),&
&attr('       default                                                  '),&
&attr('       gt                                                       '),&
&attr('       clear                                                    '),&
&attr('     dual-value (one for color, one for mono):                  '),&
&attr('       <ERROR>ERROR                                             '),&
&attr('       <WARNING>WARNING                                         '),&
&attr('       <INFO>INFO                                               '),&
&attr('')

write(*,'(a)')attr([character(len=80) :: &
'<e><W>This is an array of strings      ', &
'<r>red</r>, <g>green</g>, <b>blue</b>', &
'<c>cyan</c>, <m>magenta</m>, <y>yellow</y>', &
'<un>underline</un>', &
'       ', &
'       ', &
'       '])

! read stdin and run it through M_attr::attr to display color
   ! write as plain text
   call attr_mode(manner='raw')
   call attr_mode(manner='plain')
   call attr_mode(manner='color')
   !call attr_mode(manner='dump')
   call attr_update('Z',char(27)//'[1m')
   line=''
   write(*,'(a)')&
&attr('<y><B>WELCOME:</B></y> enter text to have it assigned attributes'),&
&attr('     Like <lt>W<gt><lt>r<gt>Red text on a White background      '),&
&attr('')
   do 
      read(*,'(a)',iostat=ios)line
      expanded = attr(trim(line))
      write(*,'(a)') expanded
      if(ios.ne.0)exit
   enddo
   write(*,'(a)',advance='no') attr('<reset>')
end program demo_M_attr
