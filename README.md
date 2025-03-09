![sample](docs/images/snap3.gif)

## Name

### M_attr - use in-band signaling to control the text attributes, formatting, color, and other output options on ANSI video text terminals

## Description

   M_attr(3f) is a Fortran module that writes common ANSI escape
   sequences which control terminal attributes like text color. It is
   designed to allow the sequences to be suppressed and for the user
   program to completely customize it -- the user can add, delete and
   replace the sequences associated with a keyword without changing
   the code.

## Functional Specification

   Attributes are specified by writing lines with HTML-like structure.

   **This is how the interface works --**

   Call the attr(3f) function with strings that include syntax like
   "\<attribute\> My regular text \</attribute\>" and the "attribute"
   and "/attribute" names will be replaced with ANSI escape sequences or
   user-defined strings associated with those keywords.
```fortran
   program demo_M_attr
   use M_attr, only : attr
      print *, attr('<GREEN><bold><white> Hello World!</white></bold></GREEN><reset>')
      ! or
      print *, attr('<G><bo><w> Hello World!')
   end program demo_M_attr
```
---
![docs](docs/images/docs.gif)
---

## Documentation
### User

All documents are contained in the docs/ directory including
archive files of man(1) pages that can be installed on ULS
(Unix-Like Systems).

If your browser supports Javascript you can view all the procedure
descriptions in an amalgamated book form that can easily be printed
or viewed as a single document:
   - [_book_](https://urbanjost.github.io/M_attr/BOOK_M_attr.html)

Which is also available as indexed HTML documents
   - [index](https://urbanjost.github.io/M_attr/man3.html)
or simply as HTML
   - [M_attr](https://urbanjost.github.io/M_attr/M_attr.3m_attr.html)  -- An overview of the M_attr module
   - [attr](https://urbanjost.github.io/M_attr/attr.3m_attr.html)  -- the main function
   - [attr_mode](https://urbanjost.github.io/M_attr/attr_mode.3m_attr.html)  -- setting processed or plain output mode
   - [attr_update](https://urbanjost.github.io/M_attr/attr_update.3m_attr.html)  -- customizing
   - [alert](https://urbanjost.github.io/M_attr/alert.3m_attr.html)  -- standard INFO, WARNING, ERROR format ![alert](docs/images/alert.gif)

---

![gmake](docs/images/manpages.gif) Documents may be installed as man-pages on Unix-like systems with a man(1) command:

   + [manpages.zip](https://urbanjost.github.io/M_attr/manpages.zip)
   + [manpages.tgz](https://urbanjost.github.io/M_attr/manpages.tgz)
### Developer
#### doxygen

- [doxygen(1) output](https://urbanjost.github.io/M_attr/doxygen_out/html/index.html).

#### ford

- [ford(1) output](https://urbanjost.github.io/M_attr/fpm-ford/index.html).

## Download and Build

---
![gmake](docs/images/gnu.gif)
---
   compile the M_attr module and example programs using make(1):
   ```bash
       git clone https://github.com/urbanjost/M_attr.git
       cd M_attr/src
       # change Makefile if not using one of the listed compilers
       make clean; make gfortran    # for gfortran
       make clean; make ifort       # for ifort
       make clean; make nvfortran   # for nvfortran
   ```

---
![fpm](docs/images/fpm_logo.gif)
---

### fpm

   download the github repository and build it with
   [Fortran Package Manager](https://github.com/fortran-lang/fpm)

```bash
   git clone https://github.com/urbanjost/M_attr.git
   cd M_attr
   fpm test
```

   or just list it as a dependency in your fpm.toml project file.

```toml
   [dependencies]
   M_attr        = { git = "https://github.com/urbanjost/M_attr.git" }
```

---
## Demo Programs
![demos](docs/images/demo.gif)

The included demo programs provide templates for the most common usage:

- [default](test/default.f90) - simple demo setting color
- [custom](test/custom.f90) - how to add, delete, and replace attribute strings
- [mixed](test/mixed.f90) - multiple modes and mixed attributes

- [dump](test/dump.f90) - dump the dictionary. Intended for debugging but might be generally useful.

- [message](test/message.f90) - using pre-defined message prefixes of various types

- [redirect](app/redirect.f90) - a complete little application showing how to call ISATTY(3f) in
                                 gfortran(3f) and ifort(3f) to automatically turn color off when output
                                 is not to a tty device.
- [plain](app/plain.f90) - a simple filter program that strips "raw mode" output back to plain text

- [color](app/light.f90) - a filter program that displays a "raw mode" input file in color
                            (or displays command line arguments). So you
                            can read in a file generated in "raw" mode
                            and display it in color, or use it for testing
                            commands or for adding color from scripts:
```text
        light "<clear><WHITE><blue><bold> WARNING: <reset> that would not be prudent"
```
### A Basic Introductory Program

This short program will display colored text on an ANSI-compatible color terminal
or terminal emulator:

```fortran
   program demo_M_attr
   use M_attr, only : attr, attr_mode

      write(*,'(/,a,/)')attr('<GREEN><bold><white> COLOR <reset>')
      call printme()

      write(*,'(/,a,/)')attr('<G><bo><w> DO THE SAME THING IN "PLAIN" MODE')
      call attr_mode(manner='plain')
      call printme()

   contains
   subroutine printme()
      write(*,'(3x,a)') attr('<W><bo><r> ERROR   </W>  This should appear as red text</y>')
      write(*,'(3x,a)') attr('<B><bo><y> WARNING </B></y>  This should appear as default text')
   end subroutine printme

   end program demo_M_attr
```
---
![sample](docs/images/snap1.gif)
---

### Note:
   where supported the isatty(3f) function can be used to turn off the sequences when the file is
   not a tty.  isatty(3f) is an extension, but supported by GNU, Intel, PGI, ...

## [History](HISTORY.md)

---
### References
* [**Fortran Wiki example**](http://fortranwiki.org/fortran/show/ansi_colors) for an example that covers the basics
* [**Rosetta Code examples**](https://rosettacode.org/wiki/Terminal_control/Coloured_text) for how other languages do color.
  I find the Ncurses, Fortran, bash and C++ examples particularly interesting.
* [**Wikipedia**](https://en.wikipedia.org/wiki/ANSI_escape_code) a description of the basic ANSI escape sequences.
* [**Fortran Standard Library project**](https://github.com/fortran-lang/stdlib/issues/229) discussion about
  adding ANSI control sequences to the Fortran Standard Library project.
* [terminal colors](http://www.pixelbeat.org/docs/terminal_colours/)

### Of Interest
* [ansi2html](https://github.com/ralphbean/ansi2html) ANSI escape codes to HTML from programs and as a bash shell

### Alternatives
* [**M_ncurses**](https://github.com/urbanjost/M_ncurses) A Fortran interface to Ncurses(3c)
* [**M_escape**](https://github.com/urbanjost/M_escape) A multi-mode exploratory version from which M_attr(3f) evolved
* [**FACE**](https://github.com/szaghi/FACE) A Fortran library for generating ANSI escape sequences
* [**foul**](http://foul.sourceforge.net/) A library for controlling the attributes of output text using Fortran

### Other Languages

*  [python](https://python-prompt-toolkit.readthedocs.io/en/master/pages/printing_text.html#html) prompt-toolkit

---

+ [CHANGELOG](docs/CHANGELOG.md)
+ [Build Status](docs/STATUS.md)
![sample](docs/images/snap2b.gif)
