# Finding Files

Linux systems has many files. **locate** and **find** commands allow to find them. **grep** searhes for text in a file

## Locate: find files by name

once per day the **updatedb** command is run in roder to gather names of files in Linux system and add them to database. **locate** command will allow to query this database.

- finds files faster using the **locate** command instead of **find**. however **locate** relies on the database update once a day
- not everything is checked with **updatedb**. remotely mounted filesystems, optical drives, temporary files 
- configuration located in "/etc/updatedb.conf"

my current config. had to be explicitly installed
```
PRUNE_BIND_MOUNTS = "yes"
PRUNEFS = "9p afs anon_inodefs auto autofs bdev binfmt_misc cgroup cifs coda configfs cpuset cramfs debugfs devpts devtmpfs ecryptfs exofs ftpfs fuse fuse.encfs fuse.s3fs fuse.sshfs fusectl gfs gfs2 hugetlbfs inotifyfs iso9660 jffs2 lustre mqueue ncpfs nfs nfs4 nfsd pipefs proc ramfs rootfs rpc_pipefs securityfs selinuxfs sfs shfs smbfs sockfs sshfs sysfs tmpfs ubifs udf usbfs vboxsf"
PRUNENAMES = ".git .hg .svn"
PRUNEPATHS = "/afs /media /mnt /net /sfs /tmp /udev /var/cache /var/lib/pacman/local /var/lock /var/run /var/spool /var/tmp"
```

due to permissions. any files in *updatedb* shown to users can be viewed normally. /root files canot be seen by normal user and as such **locate** cannot show them.

- when searching string it can appear in any part of path
- in order to manually update the database run **updatedb** as root

```bash
locate .bashrc # will find stuff in /etc/skel and in user home directory

sudo locate .bashrc # will find stuff everywhere

locate -i color # will ignore the case
```

locate command will find anything that has the INPUT in the path text

## Find: Searching files

considered to be the better one for finding files. will search filesystem live but will allow for custom starting point to make search faster. all file attribute can be used as search option.

```bash
find # will find everything in the CWD. 
find /etc # error since normal user cannot read /etc
sudo find /etc # list all files and directories in /etc
find $HOME -ls # gives long listing of the things being searched for
```
### Finding Files By Name

passing `-name` and `-iname` opdations will search directory for the passed string in the filename

```bash
find /etc -name passwd # will find the files with strictly the string "passwd" as name

find /etc/ -iname '*passwd*' # fill find files with "passwd in any part of filename
```

### Fine by Size

`-size` will allow to pass a size and find files that meet or exceed the expecifiend file size

```bash
find /usr/share -size +10m # find files greater than 10 megabytes

find /mostlybig -size -1m # find files smaller than 1 megabytes

find /bigdata -size +500m -size -5G # find files that are bigger than 500m and smaller than 5G
```

### Find by user

`-user` will search for files by owner/username. please note that this would require either root or appropiate permissions for that user's files

```bash
find /home -user cxi -ls # will look for files in the chris home directory and will show -ls options. 

sudo find /home \(-user cxi -or -user joe\) -ls # will allows us to use root privalges in order to find files in home directories of other users

sudo find /etc -group ntop -ls # find file owned by group "ntp"

sudo find /var/spool -not -user root -ls # find files not owned by root user
```

### Find by permission

mostly used as way to test perimission settings and security of linux system. find using chmod numbers, letters with `perm`. just convert all of the numbers to binary and imagine the seperate bits representing read, write and execute permissions for owner, group and others

```bash
find /usr/bin -perm 755 -ls # find files that match permissions

find /home/cxi -perm -222 -type d -ls # find directories "-d" that have write permissions all accross the board
```

### Find by date and time

yadayada. uses the `-mmin`, `ctime`, `-atime`

``` bash
find /etc/ -mmin -10 # find files changed in last 10 minutes

find /bin /usr/bin /sbin /usr/sbin -ctime -3 # find find anything that had been changed within last three days

find /var/ftp /var/www -atime +300 # find files that have not been accessed in 300 days or more
```

these follow convention: `amin`, `cmin`, `nmin`. a represents time since it was accessed, c represents change in file contents and n represents change in metadata. there is appropiate `atime`. the time uses days instead of minutes. 


### `not` and `or` options

used to further refine searches that contain or do not contain certain attributes

```bash
find /var/allusers \(-user joe -o -user chris \) -ls # finds files owned by either joe or chris

find /var/allusers/ -user joe not -group joe -ls # find files owned bye joe but not assigned to the joe group

find /var/allusers -user joe -and -size +1M -ls # files returned must fit the description of owned by joe and bigger than 1M
```

### Executing commands

find allows execution of commands on that files found by the entry using `-exec`. adding `-ok` will ask for prompt each time time the command is about to act upon file.

- **the `\;` part of the command is very important**

```bash
find /etc/ -iname passwd -exec echo "I found {}" \; # will find files named passwd and echo the phrase with the name of the file

find /usr/share -size +5M -exec du {} \; | sort -nr # find files in `/etc` biggern than 5M and executes du to find storage space usage. this is piped to sort to order them from smallest to largest. 

find /var/allusers -user joe -ok mv {} /tmp/joe/ \; #find all files owned by joe and move them to a directory in /tmp. but will prompt user with each file
```

## Fearching files with grep

search files and directory for specifc term. Grep will print out all of the lines that contain the search term to console. by default grep is case sensitive. Standard output can also be xsearched using this method

```bash
grep desktop /etc/services # find lines in /etc/services that contain the line desktop

grep -i desktop /etc/services # same thing but case-insensitive. 

grep -vi tcp /etc/services # find lines that DON'T contain "tcp" in the text

grep -rli peerdns /usr/share/doc # list files that contain the text peerdns somewhere in their text.

grep -ri --color root /etc/sysconfig # uses fancy color in order to make the string in the line stand out
```

## Summary

configuration of linux files and setting is mostly done via plain text files. manipulatring, finding and editing them is crucial skill. 


### Exercices Answers Commands

5. `chmod +777 TEST/*`
6. `chmod /usr/share/doc -not -ctime +300 -ls`
7. `find /usr/share/doc -size +5M -and -size -10M -exec cp {} /tmp/FILES/ \;`
8. `find /tmp/FILES -exec tar -cfv {}.tar {}`
9. `grep -r /usr/share/doc/kernel-doc* e1000`
10. `grep -ri --color /usr/share/doc/kernel-doc* e1000`