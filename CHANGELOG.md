## GPF Changelog

The intent of this changelog is to keep everyone in the loop about
what's new in the M_attr project. It is a curated, chronologically ordered
list of notable changes including`records of change such as bug fixes,
new features, changes, and relevant notifications.

---
**2021-07-29**  John S. Urban  <https://github.com/urbanjost>

### :green_circle: ADD:
       + advice(3f) was added to provide a standardized message format simply.
### :red_circle: FIX:
       + </bo> did not work on several terminal types, changed it to a more
         universally accepted value.
---
---
**2021-07-25**  John S. Urban  <https://github.com/urbanjost>

### :green_circle: ADD:
       + attr(3f) can take an array
       + chars=NN allows for creating blocks with a background color more easily
       + added elaborate sample including using ISATTY to detect if output is to
         a terminal, an underlined input field, a constant width with a background
	 color, ...
### :orange_circle: DIFF:
       + renamed parameter to RESET from CLEAR_AT_END on attr(3f)
### :red_circle: FIX:
       + CLEAR_AT_END (now RESET) was not working
---
**2021-07-24**  John S. Urban  <https://github.com/urbanjost>

### :green_circle: ADD:
     initial release
---

<!--
   - [x] manpage
   - [x] demo program
   - [ ] unit test
-->
