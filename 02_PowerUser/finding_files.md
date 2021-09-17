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

considered to be the better one for finding files. 