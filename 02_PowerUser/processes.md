# Managing Running Proccess

Linux is a multi-tasking systems whic allows for multipke programs to run concurrently. Runnning program is a process. We are allowed to list running processes, monitor system usage and managing th e processes all from the shell. 

## Processes Facts

- single command run by many users show up as multiple different processes. 
- each process contain unique `PID` that allows for identification. PID can only be reused upon termination of running program
- each process is associate with user account and group account that dictates system access. 
- kill all misbehaving processes

## Listing Processes

**`ps`** -> command allows to view processes running in system. 

**`top`** -> is more screen-oriented approach and is automatically updated

most desktop enviroments include graphical utility for monitoring system peformace and usage

### Using `ps`

used to check running programs, owners and resource utilization. 

```bash
ps u # requests usernames, time running, and other bits of information
```
output
```
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
cxi         6090  0.0  0.0 236936  2824 pts/1    Ss+  Sep22   0:00 /usr/bin/fish
cxi        35112  0.0  0.0 161072  6200 pts/4    Ssl  Sep22   0:00 fish
cxi        42758  0.0  0.0 160648  7240 pts/0    Ss+  09:41   0:00 /usr/bin/fish
cxi        44907  0.0  0.0 160928  7616 pts/5    Ss+  09:58   0:00 /usr/bin/fish
cxi        53569  0.0  0.0  10292  3484 pts/4    R+   12:05   0:00 ps u
```

stat column represents status such as sleeping S and R currently running. we can see that the command `ps u` shows up here.
PID is unique for every single process.

**VSZ** -> Virtual set size. is size of image process in kilobytes.

**RSS** -> Resident set size. size of program in memory. 

difference here is that VSZ is the allocated memory for process the RSS is the actual amount of physical memory used.

background processes perform simples tasks such as logging, network listening. Known as services and start automaticall at boot time. 

`-o` option with ps will allow to add filters on ps command output. `-e` will show ALL currently running processes.

```bash
ps -eo pid,user,uid,group,gid,vsz,rss,comm # will show currently running threads and only show the relevant columns

ps -eo pid,user,uid,group,gid,vsz,rss,comm --sort=-vsz # will sort by VSZ largest to smallest
```

### Using Top

uses more TUI based method for listing processes. in order to kill processes and change the nice value, `top` must be run as root.

also shows other bits of information such as total cpu usage, RAM usage, system uptime, etc

```
top - 20:54:25 up  1:51,  1 user,  load average: 0.82, 1.03, 0.90
Tasks: 294 total,   1 running, 293 sleeping,   0 stopped,   0 zombie
%Cpu(s):  3.6 us,  1.2 sy,  0.0 ni, 94.5 id,  0.0 wa,  0.4 hi,  0.3 si,  0.0 st
MiB Mem :  11713.9 total,   5029.1 free,   3130.9 used,   3553.9 buff/cache
MiB Swap:   8192.0 total,   8192.0 free,      0.0 used.   7564.1 avail Mem

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
    481 root      20   0  593300 108220  58880 S  17.2   0.9   9:06.56 Xorg
   7500 cxi       20   0  787424  87344  55680 S  14.2   0.7   0:11.61 alacritty
    694 cxi       20   0 1009420 127908  90028 S   2.6   1.1   2:18.26 xfwm4
   7234 cxi       20   0 1509660  91832  59056 S   2.6   0.8   0:30.98 rhythmbox
   2958 cxi       20   0 3390640 443900 207056 S   2.3   3.7   3:52.54 firefox
    704 cxi        9 -11 1360056  15884  11188 S   1.7   0.1   0:15.75 pulseaudio
    736 cxi       20   0  397696  38588  27656 S   1.7   0.3   1:51.89 panel-7-netload
   3267 cxi       20   0 2462492 104660  86868 S   0.7   0.9   0:08.62 Web Content
   7092 cxi       20   0   40.5g 158480  75040 S   0.7   1.3   1:39.66 codium
   8374 cxi       20   0   11120   4384   3504 R   0.7   0.0   0:00.08 top
   ```

   info is redisplayed every 5 seconds. 

options include

- `h` to see help
- `m` to sort by RAM usage
- `1` to toggle CPU usage for all cores
- `r` reverse sort
- `u` enter username to display processes for user

common practice is to use top to find misbehaving processes adn kill with PID. or to re-assign nice value. heres how to do it with `top`

- **Renice** -> press `r`. enter PID, enter nice value in set [-20, 19]
- **kill** -> pres `k`. enter 15 for clean termination oi 9 to kill. 

### Using GNOME system monitor

pretty intuitive. by default only user processes are listed. right click to perform actions on processes.

- `stop` -> pauses
- `continue` -> continues paused process
- `end` -> terminate cleanly
- `kill` -> send kill signal 9 to end immediatly and recover the memory
- `memory maps` -> allows one to view shared libraries of process in conjunction with other processes. 
- `open files` -> which files are loaded into memory due top this file

## Managing Background and Foreground Processes

within of context of terminal only enviroment. bash shell allows for movement of background processes between foreground and background. 

to add command to background add "&"

```bash
ping www.google.com -c 3 &
```

`at` command can also be used. run `CTRL-Z` to move current proccess to background. type `bg` to bring process back to foreground. 

### Placing processes in background

bash allows running commands and setting in background in order to be able to use shell again immediatly.

```bash
find /usr > /tmp/allusrfiles & # command will take a long time to complete to set it in background in order to do other work
```

we can also use the `CTRL-Z` shortcut in freaking vi. while your are in normal mode.

- typing `jobs -l` will show currently running jobs. `-l` will show the PID of the jobs 
- jobs that require terminal input or processes that use the x-server that require ionput are paused while in the background. 
- `fg %1` will bring job 1 back the the fg


fg options

- `%` -> refers to most recent command in bnackground. 
- `%string` -> job the begins with particular string. if two of the jobs have same string then error is returned
- `%?string` -> starts with string at any point.
- `%--` -> refers to stopped job

stopped job can be restarted by running

```bash
bg %5
```

it will now continue to run in the background

## Killing and Restarting Processes

both command line tools and GUI tools can be used in order to manage processes. 

### Using `kill` and `killall`

besides killsing stuff, these commands can be used to send valid signals to processes. 

1. kill process
2. reread configuration
3. pause
4. continue after pause
5. etc..

signals include but are not limited to `SIGKILL[9]`, `SIGTERM[15]`, `SIGHUP[1]`. Signal 15 will terminate cleanly. Signal 9 will kill immediatly with no regards to concequences. Signal 1 can have different behaviour depending on program but mostly it is reread configuration files. 

`SIGSTOP` will pause and `SIGCONT` will unpause. 

actual values of the signals depends on the CPU architecture. I am current running an x86_64 architecture.

important signal table

| Signal | Num | Description|
|--------|-----|------------|
| SIGUP | 1 | hand up detected in terminal or death of controlling processes/owner is dead
| SIGINT | 2 | keyboard interrupt |
| SIGQUIT | 3 | quit from keyboard |
| SIGBRT | 6 | Abort signal |
| SIGKILL | 9 | kill signal |
| SIGTERM | 15 | termination |
| SIGCONT | 19,18,25 | continue if paused |
| SIGSTOP | 17,19,23 | pause process |

 usage of `kill`

 ```bash
 kill 10432 # default signal is 15
 kill -15 10432 # specifies signal 15
 kill -SIGKILL 10432 # sends signal 9
 ```

 usage of `killall`

 ```bash
 killall -HUP gnome-shell # used sends signal 1 to reread configuration and restart
 ```

 using `killall` to kill processes by name genereally means that all the processesx that have the same name are also killed. so be careful. like `killall  bash` wil kill all bash shells. 

 ### Setting Priority with nice and renice

- linux kernel uses nice value of processes in order to determine the priority to processes to receive CPU processing time. 
- nice values exist in range [-20,19]. default value is 0
- lower nice value means more priority and greater access to CPU time. 
- negative nice values require root access in order to set. 
- regular user can only increas the nice value not lower. 
- can only edit nice value for processes that are owned by user. 
- root user has full acesses to nice editing

using `nice` will run  command with certain nice value. `renice` will change nice value of PID

```bash
sudo nice -n +5 updatedb & # will run updatedb with nice value of 5 as root

renice -n -5 20284 # reassigns nice value to -5
```

## Limiting Processes with `cgroups`

using `nice` will only affect a single PID. does not apply to child processes or other related processes that are part of same service. in a cloud computing world Linux systems will be used as hypervisors to VM's that run the servers. resource access must be properly assigned to each of the VMs. 

Cgroups are used to link processes to task belonging to control group. Control groups can exist such as daemons to set resource utilization by daemons. These are known as tasks and subtasks include server daemons

when a task launches a process any child of parent will inherit the limitations set on parent. such restrictions can include CPU usage, RAM usage, specific CPU core usage, processing time. here is list

1. Storage(`blkio`) -> limits total output and input to storage devices. 
2. Processor Scheduling(`cpu`) -> amount of access for CPU time
3. Process Accounting(`cpuacct`) -> reports CPU usage, used to charge clients of cloud providors for processing power usage
4. CPU Assignment(`cpuset`) -> assign task to particular set of processors and associated memory
5. Device Access(`devices`) -> allows task to open and/or create selected devices
6. Suspend/resume(`freezer`) -> suspend and resume abvilities
7. Memory Usage(`memory`) -> limits memory usage of task and can report on memory usage
8. Network Bandwidth(`net_cls`) -> limits network access. done by tagging network packets with cgroup identifier and using Linux traffic controller
9. Network Traffic(`net_prio`) -> set priority on network traffic from cgroups and allows for reassignment of priorities
10. Name Spaces(`ns`) -> seperates cgroups into namespaces, only allows processes to view namespace associated with cgroup. such information can include processes tables, mount tables, and network interfaces

managin all of this is not the job or newbies. requires editing configuration files and careful consideration. mistakes can mae system unbootable

used by linux in order for greater controll over Linux resource utilization. 

## Further information
[**Red Hat Enterprise Linux Resouce Management and Linux Containers Guide**](https://access.redhat.com/documentation/en_us/red_hat_enterprise_linux/7/html-single/resource_management_guide/index)

[**Kernel Documentation**] (/usr/share/doc/kernel-doc-*/Documentation/cgroups)

## Summary

Linux systems do a lot of stuff. Here is how to view and manage them. 

## Exercises Answers

1. `ps | less`
2. `ps -sort name` | less
3. `ps -eo pid,user,group,vsz,rss,command`
4. `top`, click 1 or m
5. use system monitor to kill gedit
6. use kill command to pause gedit
7. use killall to unpause gedit
8. `killall xeyes`
9. `nice -5 gedit`
10. `renice 7 -p 36959`
