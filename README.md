# Embedded Linux
## Windows Subsystem For Linux (WSL)
### Install
```
> wsl --list --online
> wsl --install Ubuntu-22.04
> wsl --list
```
### Upgrade
```
$ sudo apt update
$ sudo apt upgrade -y
$ sudo apt install -y autoconf bc bison bzip2 cpio file flex g++ gawk gcc genext2fs git help2man libncurses5-dev libssl-dev libtool-bin make qemu-system-arm qemu-user rsync sudo texinfo u-boot-tools unzip wget xz-utils
$ mkdir -p ~/git/ ~/scratch/bbb/ ~/scratch/qemu/
$ cd ~/git/
```
## Examples
* [Build From Scratch](SCRATCH.md)
