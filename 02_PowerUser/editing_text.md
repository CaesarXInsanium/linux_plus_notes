# Chapter 5: Working WIth Text Files

in early days, systems were only change via editing text files. Most often  configuration is done in plain
text files. Most linux server do not have a graphical enviroment.

## Vi and Vim

text editors are essential for managing textfiles and system configuration.

book continues into a vi tutorial. here are some pointers
- left h
- down : j
- up: k
- right l
- there are two modes. command and input

### Keys: no colon
**a** ->  enter input mode at right of cursor

**A** -> enter input at end ofg line. ooh yeah

**i** -> enter insert mode. input are left of cursor

**I** -> enter insert mode at beginning of line.

**o** -> add new line below and enter insert mode

**O** -> open above in insert mode

### Movement

- only a dirty pleb would use arrow keys in vim. 

**w** -> move to beginning of next word

**W** -> basically same as above. canmt bne bothered

**b** -> move to beginning of previous workd

**0** -> moves cursor to beginning of current line

**$** -> move to end of current line

**H** -> moves cursor to upper left in current screen. not beginning of file

**M** -> move cursor to first character of middle line of screen

**L** -> move cursor to lower left of screen.

### Deletion and Copy

no such thing as ctrl+c and ctrl+v


## Alternative Editors

- nano : terminal based, user friendly
- gedit: gtk based graphical editor. use in gnome
- jed: terminal bsed text editor. 
- kate: qt based editor. used in KDE
- kedit: same as kate
- mcedit: uses function keys to move around and for common function.
- nedit: 
