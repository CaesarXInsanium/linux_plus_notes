# Shell

## What is it?

- shell is way foruser to interect with computer. mainly text based shells allow user to type intext as commands and computer will output result
- on most systems the default shell is bash

## Command Line editing - check page 73-77 of linux bible

crtl-d : will delete at cursor

## Connecting and Expanding Commands

| -> pipe symbol will take output from one command and pass to another as an argument to work with

```bash
cat /etc/passswd | sort | less
```

; -> semicolo will allow one command to finish and another ti start

```bash
date ; troff -me verylargedocumnet | lpr ; date
```
& -> ampersnd symbol will run command in background
```bash
picom &
```

## Command Substitution

allow for output of command to be interpreted by shell instead of command

```bash
vi $(find /home | grep xyzzy)
```

## Arithmetic

pass result of math to shell
```bash
echo "I am $[2021 - 2000] years old"
```

## Variables

variables to store information are expanded with dollar sign $

```bash
echo $PATH
```

## Alias

easy way to create shortcut to command with options and such
```bash
alias update="sudo apt update;sudo apt upgrade"
```
## Common Variables

|Name|Usage|
|----|-----|
|BASH| full path to bash|
|HOME|path to current user home directory|
|OSTYPE| describe the OS type|
|PATH| list of directories containing executables that can be accessed in shell|
|PS1| bash shells prompt variable|

## Customization

 Files to edit

- /etc/profile -> set environment info for all users on first login
- /etc/bashrc -> executes for all users. can be override by $HOME/.bashrc
 - ~/.bash_profile -> same as /etc/profile
 - ~/.bashrc -> set for each individual user on summoning terminal

 In order to immediatly set bash settings after change in bashrc run
 ```bash
 source ~/.bashrc
 ```

 ## Bash Prompt

Fun things to add to prompt

- "\W" -> current directory base
- "\[" -> being series of non-priting characters
- "\]" -> end
- "\h" -> hostname
- "\n" -> newline
- "\u" -> username

## Setting Enviroment Variables

### TMOUT

set how long shell will remain active with no user input. usefull for security

### PATH
list of directories that contain executables

## Command Information

typing help will show reserved commands associated with shell and what they do.

- options include the "info" command and "man" command
- pass "--help" to command to show snippet of command usage in most cases

```bash
help
```

## Man Page Sections

1. User Commands: commands that can be runb regular user
2. System Calls: programming functions that makes calls to kernel
3. c library Functions: provide interface to specifc programming libraries
4. DEvices and Special Files: Filesystems nodes represent the hardware devices 
5. File formats and conventions: types of files, binary layout
6. games: games
7. miscallenous: overview of protocols, filesystems, character set standards and so fort
8. system administration tools and daemons

passing the man command will search the man database or show the man page for specifc command

```bash 
man man
```

## Exercies Answers

command to output the date in M/D/Y format is
```bash
date "+%D"
```
