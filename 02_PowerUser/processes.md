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

