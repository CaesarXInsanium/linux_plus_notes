# Moving Around the Filesystem

## Intro

-  filesystem in everything is stored in a linux system
- everything that can be worked with can be accessed vie the filesystem in some form or another
- entire linux file structure is shaped like upside down tree. everything is a file including reporesentation of physical hardware and screens

##  GNU/Linux System Directories

**/bin** : common linux user commands. ex: ls, sort, date, chmod

**/boot** : bootable linux kernel, ram disk, boot loader configuration and GRUB

**/dev** : contains files the represent access to physical devices. terminals(tty), hard disks, RAM. 

**/etc** : configuration files that control the system including profile, fstab and hostname

**/home** : contains home directories of known non-root users that can be logged into

**/media** : standard location that contains mount-points of removable storage devices. 

**/lib** : shared libraries by boot /bin and /sbin foor booting system

**/mnt** : generally used as mount point when mounting hard disks of other linux filesystems wether remote or local. for maintanace and othe rstuff maybe

**/misc** : mount point for auto mount of filesystems

**/opt** : place to store add-on applications

**/proc** : info on system resources

**/root** : home directory of root user

**/sbin** : system executables that can only be run as root and other daemons

**/sys** : parameters for block storage and management of cgroups

**/tmp** : contains temporary files that can be deleted at any point in time

**/usr** : contains user documentations, games, graphical files, libraries, user installed binaries. generally treated as a read only directory

**/var** : data for various applications. log files. spool files. mounted on seperate expandable filesystem when on servers

## Metacharacters

Help in copying removing and acting upon files with ease and without knowing exact names of each individual file working one

### *

matches any number of  characters

### ?

matches any one character

### [...]

matches any character between the brackets

### Examples

```bash
ls *a # matches with anything that ends in letter a
ls g*t # matches anything that starts with g and ends with t

ls ????a # matches anything that has 5 total characters and end with a

ls [abw]* # matches anything that has the characters a, b and w
ls [a -v]* # anything from letters a trough v in english alphabet

ls [a-c]? # matches any one character from a to c
```

## File re-direction

redirect output of command into other command or into file. redirect stout or sterr. 

### | 

pipe will direct output of one command into another

### <

Direct contents of file to command.generally notnuseful since commands can take file paths as input and work on the files

### >

direct standard out to file. if file exists then contents will be over written

### >> 

append output to end of file

### 2>

directs standard error, error messages

### &>

directs both stout and sterr to file

### Examples

```bash
mail root < ~/.bashrc

man chmod | col -b > /tmp/chmod

echo "I finished the project on $(date)" >> ~/projects
```

### Brace Expansion Characters

using curly braces one can expand out character across the filenames, directories, and arguemttns

```bash
touch memo{1,2,3,4} # will create files memo,memo2,...etc

touch {John,Bill,SAlly}-{Breakfast,Lunch,Dinner} # will create files with all the described combinations

rm -f {John,Bill,SAlly}-{Breakfast,Lunch,Dinner} # will delete all of those files

touch {a..f}{1..5} # will create combinations from the ranges. all letter from a to f, 1 to 5
```

## Listing Files

ls command from GNU/Core utils will list out directories in current working directory or the provided directory path.

```bash
ls --color=auto -al
```

when adding "-l" and "-a" to flags in ls we see this

```text
-rw-r--r-- 1 cxi users 0 Aug 15 08:10 apple
lrwxrwxrwx 1 cxi users 5 Aug 15 08:11 pointer_to_apple -> apple
-rwxr-xr-x 1 cxi users 0 Aug 15 08:10 script.sh
drwxr-xr-x 1 cxi users 0 Aug 15 08:11 Stuff
-rw-r--r-- 1 cxi users 0 Aug 14 20:42 watermelon
```

first character indicates the type of thing that ls is listing

- **-** -> normal file
- **d** -> directory
- **l** -> link to file
- **x** -> executable file

### Notes

- the "-l" option will show information about disk usage on files, date last modified,  permissions,
- "-a" will show hidden files. 
- size of directory actually show the size of the file holding infomration about the directory. can row according to number of files in directory
- "s" in execute permissions means that when file is executed by user the proccess automatically becomes owned by another user or group
- "t" to end of directory is the sticky bit. anybody can add and edit files in directory but nobody can delete files belonging to other people
- "~" tilde represent home directory. "~joe" represent home directory of user joe
- files and directory starting with period are hidden and cannt be viewed unless certain flags are used

### ls flags

- **-a** -> list out hidden files and directories
- **-t** -> sort items by last modified
- **-F** -> list only files
- **--hide=** -> hides files that matches criteria

Examples

```bash
ls --hide=g* # will hide any file that begins with g

ls -ld $HOME/test # will only show information on directory
```

## File Permissions

bits on file meta data describe access to different users and groups in linux. 3 bits for owner group owner is in and all other users. 9 bits total describe file permisions

binary bit permissions are

- read -> view contents of file or directory
- write -> change file content, rename. delete. add file to directory, rename subdirectories
- execute -> run file as program. can change into directoryu as current directory, execute program in directory, access file metadata and search trough directory

### Chmod command

use command chmod to change permissions of file as owner

using numbers

```bash
chmod 777 file # gives al permissions to all users
chmod 755 file # rwxr-xr-x. owner full access. group everybody gets read and execute
chmod 644 file # rw-r--r-- owner reade write only and everybody else gets read only

chmod -R 755 $HOME/directory-path # sets permissions to directory, all files in folder and subdirectories recursively
```

Letters can be used with chmod to set permissions. Permissions ared added or subtracted to users and groups denoted with "u" for user/owner, "o" for other, "g" for group, "a" for everybody

```bash
chmod a-w file # r-xr-xr-x remove execute permissions for everybody
chmod o-x file # rwxrwxrw- remove execute permissions for other
chmod go-rwx file # rwx------ remove all permissions for everybody except owner
chmod u+rw file # add read write for user

chmod -R o-w $HOME/test_directory # changes permissions recursively
```

### umask: Setting default permissions

defautl permissions set to file or directory whenever user creates a file. passing command "umask" will echo the default permissions. works like subnet mask and works on default permissions 666 for files and 777 for directories

```bash
umask # output: 0022

umask 777; touch file01 ; mkdir dir01 ; ls -ld file01 dir01 # will give no permissions for anything
#d--------- 1 cxi users 0 Aug 16 07:28 dir01
#---------- 1 cxi users 0 Aug 16 07:28 file01
umask 000; touch file02 ; mkdir dir02 ; ls -ld file02 dir02 # will give all permissions except execute permissions for files
#drwxrwxrwx 1 cxi users 0 Aug 16 07:29 dir02
#-rw-rw-rw- 1 cxi users 0 Aug 16 07:29 file02
```

### chown: Changing file ownership

using chown command to set owner of file

```bash
chown joe /home/joe/memo.txt # set owner to joe
chown joe:wheel /home/joe/memo.txt # set owner and group of file
```

## Moving, Copying, Removing

**mv** moves file to location path or renames file. Some systems have this command aliased to a more useful

```bash
mv abc def # rename file to def
mv abc ~/abc # movem file to home directory
mv /home/joe/mymemoes /home/joe/Documents # moves file and renames
```

**cp** copies file to new location, creating identical file byte for byte

```bash
cp abc def
cp abc ~/abc
cp -r /usr/share/doc/bash-completion* /tmp/a # recursively copy directory bash-completions and eveyrthing inside new directory
cp -ra /usr/share/doc/bash-completion* /tmp/a # sanme thing but dates meta data is also copied and samne permissions are maintained instead of using umask
```

**rm** removes files and directories. requires "-r" for recursively deleting directories and files inside of directories

```bash
rmdir /home/directory # deletes onyl empty directory
rm -r /home/joe/yeet # remove files inside of directory. prompt is presented for protected files
rm -rf /home/joe/yeet2 # removes protected files. with no prompt
```

