# Writing Simple Shell Scripts

most use method of getting work down in terminal is to use shell scripts.  Scripts are used to do basic startup services in older linux systems. **Shell Script** is group of commands, functions, variables in oder to make a full shell

Moderm methods of system administration and automation include ansible playbooks, Kurbenetes YAML files. Shell scripts are still the best way to automate. 

## Understanding Shell Scripts
___

scripts are programs that run commands automatically as if done by user. 

### Executing and Debugging

- short scripts run fast and large one are slow
- same principles for proper software development apply for writing scripts especially in production enviroments
- use lots of print i mean echo statements
- pass `-x` to bash command in order to echo out the commands being used by the script


two ways to start scrips

1. when filename is used as argument to shell
2. use of format `#! /bin/bash` on top of file and then add execute permissions to file for user

items following name of program are treated as arguments for scripts

```bash
bash scriptname.sh arg1 arg2
./scriptname arg1 arg2 # assume script has execute flag on
```

### Shell Variables

- variable names are case sensitive
- can be used to store long string data such as path or tings that might change
- used dollar sign to evaluate the value of a variable
- variables can contain values of other variables

```bash
NAME=value
CITY="Springfield"
PI=3.141492654
BALANCE="$CurBalance"

MYDATE=$(date) # assigns output of date command to variable MYDATE
MYDATE=`date` # does same thing

```

### Escape Characters

have special meaning in context of shells. `echo $HOME` will display value of HOME variable not word HOME. used escape `\`  character in order to show `$HOME`

```bash
echo "$HOME * `date`" # will echo the HOME path and the value of date command, notice use of alternating quotation marks
MACHINE=`uname -n`
NUM_FILES=$(/bin/ls | ws -l) # directly executes ls in to list items in cwd and counts number of items
```

### Shell Positional Characters

command line arguments: in array $0, $1, $2, $3, ...etc

```bash
#! /bin/bash
# script to echo out the values of the command line arguments
echo $1 # $0 is actually the script name itself
echo "Enbed the value of $2 in text"
echo "The number of arguments passed are $#"
echo "Here are all arguments: $@. We can iterate over this"
```

### Prompting User

use `read` command to prompt user for input

```bash
read -p "text to prompt user" var1 var2 var3 # command to ask user input and variables to store values in
# in order to properly enter values for all we will need to seperate each value with a space
```

### Paramter Expansion

`$HOME` is short for `${HOME}`. Curly braces are used in instances when space are not available. They can also be used other syntatic sugar

```bash
THIS="example"
THIS=${THIS:-"NOT SET"}
THAT=${THAT:-"NOT SET"} # sets THAT to value of THIS. if THIS is not set then set value to "NOT SET"
```

variables can also be modified using certain syntatic sugar

```bash
MYFILENAME=/home/cdigby/myfile.txt # set values
FILE=${MYFILENAME##*/} # cuts out extra stuff and leaves out things after the last /
DIR=${MYFILENAME%/*} # leaves only stuff at and before last /
NAME=${FILE%.*} # value of NAME becomes that of FILE
EXTENSION=${FILE##*.} # value becomes that of the text after the .
```

### Arithmetic in Shell Scripts

Bash usually treats all variables as strings but numbers can be used. Bash can automatically convert valid strings into intergers. Math can be done. 

```bash
BIGNUM=1024 # assigns value
let RESULT=$BIGNUM/16 # assigns values of division to RESULT
RESULT=`expr $BIGNUM/16` # uses expr command to evaluate result
echo "$BIGNUM / 16" | bc # bc command takes pipe from something and computes the result

I=0

echo "Value $((++I))" # increments value and then evaluates
echo "Value $((I++))" # evaluates and then increments
```

### Using Programming Constructs

usage of looping, and conditional states is possible and makes BASH a full programming language

if statemet
```bash
VARIABLE=1
if [ $VARIABLE -eq 1 ]; then # use -eq
echo "The Varaible is 1"
fi

# or it can be done like thing
STRING="FRIDAY"
if [$STRING = "Friday"]; then # can use = operator
echo "Whoohoo. Friday"
elif [ $STRING != Monday ]; then
echo "At Least it is not Monday"
else
echo "Will Friday get here?"
fi
```

other comparators

- `-d ARG` -> is directory
- `-f ARG` -> is file
- ...etc. There is a lot of other operators

testing conditional one-liners 

```bash
# [test] || action
dirname=/var/log
[-d $dirname ] || mkdir $dirname # checks if dirname is valid directory path and if not then makes it

# [test] && {action}
[ $# -ge 3 ] && { echo "True" } # if number of arguments is greater than 3 then


```

### Case Command

same as the c switch command

```bash
case `date +%a` in
	"Mon")
		BACKUP=/home/myproject/data0
		TAP=/dev/rft0
	 	;;
	"Tue" | "Thu")
		BACKUP=/home/myproject/data1
		TAPE=/dev/rft1
		;;
	"Wed" | "Friday")
		BACKUP=/dev/myproject/data2
		TAPE=/dev/rft2
	*)					# universal case
		BACKUP="none"
		TAPE=/dev/null
		;;
	esac
```

### For Loop

thing that repeats code until a condition is met or the heat death of universe is reached

```bash
for  NUM in 0 1 2 3 4 5 6		# iterate over numbers
do
	echo "The Number is $NUM"
done

for FILE in `/bin/ls`			# iterate over the output of ls command
do
	echo $FILE
done

# C syntax can bse used

LIMIT=10
for ((a=1; a<=LIMIT;a++)); do
	echo "$a"
done
```

default delimter in array using bash is the white-space character. 

### "While ..do"

repeat a thing until condition is met or condition is not longer true or something

```bash
N=0
while [ $N -lt 10 ]; do
	echo -n $N
	let N=$N+1
done

N=0
while [ $N -eq 10 ]; do
	echo -n $N
	let N=$N+1
done
```

## Text Manipulation

common useful command to manipulate text are `cut`, `tr`, `awk`, `sed`. All of these commands use the standard input and output. 

### Regular Expressions

using `grep` to full potential requires competence withr egular expressions. regular expressions allow for generic matching of text. with common patterns

examples
```bash
grep /home /etc/passwd # will list all users by matching lines that contain '/home'. only user that can be logged in as have home directory

env | grep ^HO # will list all enviroment variables that begin with 'HO'
```

### Removing Sections of text

`cut` will allows us to extract fields from lines of text. done by specifying field seperator or it can also break up the lines by bbytes

examples
```bash
grep /home /etc/passwd | cut -d':' -f6 - # take list of lines that contain loginable users and displays sixthfield with delimeter ':'```

### Translate of Delete

character based translator. can be used to replace characters with other character or set of chars with others or to remove stuff. 

```bash
FOO="Mixed UPpEr aNd LoWeR cAsE"
echo $FOO | tr [A-Z] [a-z] # will replace all instance of a upper case letter with lower case letter

# this will remove all spaces [:blank:] with underscores in files names by renaming them
for file in * ; do
	f = `echo file | tr [:blank:] [_]`
	["$file" = "$f"] || nv -i -- "$file" "$f"
	done
```

### Stream Editor

`sed` command is very useful. can replace lines with text patterns, very useful

examples
```bash
sed -n '/home/p' /etc/passwd # searches passwd file for any line that contains '/home'

sed 's/Mac/Linux/g' somefile.txt > fixed_file.txt # searchs in first file and replaces are instances of Mac with Linux and saves result into new taxt file fixed_file. 
cat somefile.txt | sed 's/Mac/Linux/g' > fixed_file.txt # same thing
```

## Using simple Shell Scripts

very useful to save commonly used set of commands in order to execute them in god way.

Now I will proceed to write the included backup script into by ~/.local/bin

On Second Tought no I won't.

## Answers to exercises

1. 
