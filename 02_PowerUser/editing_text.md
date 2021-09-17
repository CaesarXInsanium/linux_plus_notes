# Chapter 5: Working With Text Files

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

### **Keys**:🔥 no colon
**a** ->  enter input mode at right of cursor

**A** -> enter input at end ofg line. ooh yeah

**i** -> enter insert mode. input are left of cursor

**I** -> enter insert mode at beginning of line.

**o** -> add new line below and enter insert mode

**O** -> open above in insert mode

### **Movement**

*only a dirty pleb would use arrow keys in vim.*

**w** -> move to beginning of next word

**W** -> basically same as above. cant bne bothered

**b** -> move to beginning of previous workd

**0** -> moves cursor to beginning of current line

**$** -> move to end of current line

**H** -> moves cursor to upper left in current screen. not beginning of file

**M** -> move cursor to first character of middle line of screen

**L** -> move cursor to lower left of screen.

### Deletion and Copy

no such thing as ctrl+c and ctrl+v

**x** -> deletes character undercursor

**X** -> deletes text before cursor

**d<?>** -> deletes arbitrary amount of text

**c<?>** -> changes arbitrary amount of text

**y<?>** -> cuts/yanks arbitrary amount of text

use in combination with above movement to apply above tasks on text in order to do things. use by pressing apprpiate keys in linear succesion quickly

dw -> deletes word after cusor

db -> deletes word before cursor position

dd -> deletes entire line

c$ -> deletes from cursor position to end of line

c0 -> deletes from cursor to beginning to line

goes on and on. not very important will have to cut out unimportant bits

modifications using numbers

3dd -> deletes three lines from beginning of line

3dw -> deletes three words

5cw -> eraces next five lines and enters input mode

### Pasting

**P** -> if text in clipboard is one line, places to left of cursor. if multiple lines place above current line

**p** -> placesd to right of cursor if one line. below line if multiple lines of text

### Additional commands

**.** -> (period) repeats previous command. 

here we have colon commands

**:q** -> quits vim. only works if no changes have been made

**:wq** -> writes changes to disk and quits

**:q!** -> quits and forces vim to ignore changes

**zz** -> saves and quits

**w** -> quits vim but allows you to continue editing

**[Esc]** -> enter command mode from insert mode

**u** -> undoes most recent change or command

*ctrl+R* -> redo

**[CapsLock]** -> acts normally while in insert mode. LIKE THIS. But in command mode will aactually modify all of the commands as if acted with shift. 

**:!*command*** -> run shells command in vi. can run shell such as bash to do other thing and voila. can run date, pwd, like so. ":!bash" runs bash shell. its weird. it genually ecits you out of vim like a weirdo.

*ctrl+g* -> display name of file while in command mode

### Other methods

*ctrl+f* -> page ahead on at a time

*ctrl+b* -> page back on time

*ctrl+d* -> page ahead one half

*ctrl+u* -> page back one half

**G** -> goes to last line of file

**1G** -> goes to first line of file

**35G** -> goes to line number 35

### Searching text

to begin search use "/" or "?". give pattern to search for and enter. here are examples. we can also use meta characters like with scripts


"/hello" -> searchs forward for hello

"?goodbye" -. searches backwards for goodbye

"/The .\*foot:" -> searches for line the begins with 'The' and ends with 'foot' 

"?[pP]rint" -> searches backwards for for 'print' or 'Print'. 

### Ex Mode

vi editor is based off of the ex editor. still has some of those commands. Ex editor does not have fullscreen mode so editing was done by finding specific lines of text and editing them. Not important for what I am trying to do

### Alternative Editors

- nano : terminal based, user friendly
- gedit: gtk based graphical editor. use in gnome
- jed: terminal bsed text editor. 
- kate: qt based editor. used in KDE
- kedit: same as kate
- mcedit: uses function keys to move around and for common function.
- nedit: 
