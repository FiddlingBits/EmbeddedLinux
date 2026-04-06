# Kernel
## Set Up
```
$ mkdir -p $HOME/build/kernel/
```
## Clone
```
$ git clone https://git.busybox.net/busybox --branch 1_36_0 $HOME/git/busybox/
$ git clone https://github.com/raspberrypi/linux.git --branch rpi-6.1.y $HOME/git/linux/
```
## Build
```
$ cd $HOME/git/linux
$ make bcm2712_defconfig O=$HOME/build/kernel
$ ./scripts/config --file $HOME/build/kernel/.config --disable ARM64_16K_PAGES --enable ARM64_4K_PAGES
$ make olddefconfig O=$HOME/build/kernel
$ make O=$HOME/build/kernel
```
