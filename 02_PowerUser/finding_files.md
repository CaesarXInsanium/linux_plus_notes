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