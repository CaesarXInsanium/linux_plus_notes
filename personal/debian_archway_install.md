# Debootstrap BTRFS Install Notes

### Notes Before Install

canceled because Grub fucking sucks and I can't even. Maybe I am doing it wrong but I give up for now

**Update** It turns out that I was in fact doing this shit wrong. make a seperate EFI partition not a seperate boot partition. This partition would be mounted to `/boot/efi`. make sure to add the efi flag

- install network-manager once chrooted
- install arch-install-scripts before
- install debootstrap
### Important Packages Outside

- debootstrap
- arch-install-scripts
- fish -> for autocompletion
- 

### Important Packages chrooted

- efibootmgr
- network-manager
- grub-efi-signed
- linux-image
- grub-btrfs
- timeshift
- locales
- sudo
  
## Steps

### Partition Disks

- create at least 10 MiB partition, flag as efi/bootable partition
- allocate appropiate amount of swap space
- create master BTRFS partition

1. mount BTRFS volume
2. Create subvolumes for: `/`, `/home`, `/var`, `/opt`, `/tmp` directories
3. unmount btrfs
4. result: `@`, `@home`, `@var`, `@opt`, `@tmp`
5. mount subvolumes in `/mnt`
6. mount efi partition in `/mnt/boot/efi`
7. swapon that swap partition

### debootstrap

run command

```sh
debootstrap --arch amd64 bullseye https://deb.debian.org/deb
```

### Genfstab

```sh

genfstab -U /mnt >> /mnt/etc/fstab
```

### Chroot

```sh
arch-chroot /mnt
```

### Set Sources

add additional Sources to apt sources file. upgrade to testing or sid from here

### Update System and install the appropiate packages

```bash
sudo apt update && sudo apt upgrade
sudo apt install locales timeshift grub-btrfs linux-image-amd64 grub-efi-signed network-manager efibootmgr
```

### Set LANG and LOCALE

### Install Grub Bootloader

### Optional: Install additional packages

- desktop enviroment
- fish
- htop
- neofetch
- git

### Add regular User and Give appropiate sudo permissiosn

### Exit out of Chroot and Restart
