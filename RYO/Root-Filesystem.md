# Root File System
## Create Staging Directory
```
$ cd ~
$ mkdir ~/rootfs
$ cd ~/rootfs
$ mkdir bin dev etc home lib proc sbin sys tmp usr var
$ mkdir usr/bin usr/lib usr/sbin
$ mkdir var/log
$ ln -s lib lib64
```
## Clone And Configure BusyBox
```
$ cd ~
$ git clone git://busybox.net/busybox.git
$ cd busybox
$ git checkout 1_36_1
$ make defconfig
$ make menuconfig
```
1. `Settings`
    - `Destination path for 'make install'`
        - Enter `../rootfs`
2. Exit And Save
## Build Root Filesystem
### BeaglePlay
```
$ cd ~
$ cd busybox
$ make ARCH=arm64 CROSS_COMPILE=aarch64-buildroot-linux-gnu-
$ make ARCH=arm64 CROSS_COMPILE=aarch64-buildroot-linux-gnu- install
$ make distclean
```
### Copy Shared Libraries
```
$ cd ~
$ export SYSROOT=$(aarch64-buildroot-linux-gnu-gcc -print-sysroot)
$ cp -a "$SYSROOT/lib/"*.so* rootfs/lib/
$ cp -a "$SYSROOT/usr/lib/"*.so* rootfs/usr/lib/
```
## Create Device Nodes
```
$ cd ~
$ cd rootfs
$ sudo mknod -m 600 dev/console c 5 1 # System Messages, Emergency Logins, And Root Shell Access During Boot Or Single-User Mode
$ sudo mknod -m 666 dev/null c 1 3 # Discard Unwanted Output From Processes Or Provide An Empty Input Stream
```
## Create Filesystem Image
```
$ cd ~
$ echo "/dev d 755 0 0 - - - - -
/dev/console c 600 0 0 5 1 0 0 -
/dev/null c 666 0 0 1 3 0 0 -
/dev/ttyO0 c 600 0 0 252 0 0 0 -" > device-tables.txt
$ genext2fs -b 32768 -d ~/rootfs -D device-tables.txt -U rootfs.ext2
```
