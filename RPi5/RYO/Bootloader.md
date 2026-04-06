# Bootloader
## Set Up
```
$ mkdir -p $HOME/build/bootloader/ $HOME/git/
```
## Clone
```
$ git clone git://git.denx.de/u-boot.git --branch v2026.01 $HOME/git/u-boot/
```
## Build
```
$ cd $HOME/git/u-boot/
$ make rpi_arm64_defconfig O=$HOME/build/bootloader/
$ make O=$HOME/build/bootloader/
```
