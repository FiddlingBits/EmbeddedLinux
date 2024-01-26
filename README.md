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
$ sudo apt install -y autoconf bc bison bzip2 chrpath cpio diffstat file flex g++ gawk gcc genext2fs git help2man libncurses5-dev libssl-dev libtool-bin lz4 make python3-distutils qemu-system-arm qemu-user rsync sudo texinfo u-boot-tools unzip wget xz-utils zstd
$ mkdir -p ~/git/ ~/buildroot/bbb/ ~/buildroot/qemu/ ~/scratch/bbb/ ~/scratch/qemu/
$ sudo locale-gen "en_US.UTF-8"
```
## Examples
* [Build From Scratch](SCRATCH.md)
* [Buildroot](BUILDROOT.md)
* [Yocto](YOCTO.md)
