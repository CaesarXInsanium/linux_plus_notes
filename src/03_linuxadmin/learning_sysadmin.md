# Learning System Administration

Linux is intended to be used by more than one person. This allows multitasking and program to run all programs from all users.
Person in charge of it all is the **System Administrator**

In order to peform most admin taks root privilages are required. Usually done using `sudo` command.

## Basics

core of system administration is to make sure people have what they need when they need it. Certain imporant commands include

- `su` -> open root shell
- `sudo` -> run command as root. can be customized
- **Cockpit Browser** -> used by RHEL for browser based sysadmin. 
- **Graphical Windows** -> before sysadmin taks were carried out using multiple different graphical appliactions. 

Certain things must be managed to imporve health, peformance and security of system.

- filesystems
- software installation
- user accounts
- network interfaces
- servers
- security features: firewalls, user access, permissions

## Graphical Administrative Tools

most admin is done by CLI, however graphical application allow an easier method.

### Cockpit

Considered by many to be best graphical browser based sysadmin tool. Many functions are available in single application.
Uses **cockpit-bridge** API and is starting my starting relevant program as service in target. This is a server.
Enter IP address in browser and boom. Plugins allow extended functionality.

## Alternative System Config tools

Here are the old commands in old Fedora

- **Domain Name System**(`system-config-bind`) -> managed DNS zones if system is DNS server
- **HTTP**(`system-config`) -> Configure host as apache web server
- **Root Password**(`system-config-rootpassword`) -> change root password
- **Samba NFs**(`system-config`) -> Configure Windows file sharing. 

tools available in both RHEL and Fedora

- **Services**(`system-config-services`)
- **Authentication**(`system-config-authentication`) -> change user auth methods. Passwords, shadow passwords, MD5 passwords. Physical key cards and other forms of authentication an user
- **Date & Time**(`system-config-date`) -> set datetime
- **Firewall**(`system-config-firewall`)
- **Language**(`system-config-language`)
- **Printing**(`system-config-printer`)
- **SELinux Management**(`system-config-selinux`) -> set SELinux enforcing modes and default policy
- **Users & Groups**(`system-config-users`)

there are also application provided in default GNOME

- **Configuration Editor**(`gconf-editor`) -> edit GNOME configurations
- **Disk Usage Analyzer**(`gnome-utils`) -> display information about system disk usage and peformace.
- **Disk Utility**(`gnome-disks`) -> manage partitions, filesystems
- **Kickstart**(`system-config-kickstart`) -> used to install multiple linux systems without user interaction

Everything that can be done with above tolls can be done with **Cockpit**

## Other Browser Based Admin Tools

