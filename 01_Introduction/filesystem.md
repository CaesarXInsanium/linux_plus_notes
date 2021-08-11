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

**var** : data for various applications. log files. spool files. mounted on seperate expandable filesystem when on servers

## Metacharacters