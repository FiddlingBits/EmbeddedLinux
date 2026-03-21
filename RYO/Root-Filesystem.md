# Root File System
## Create Staging Directory
```
$ mkdir $HOME/build/rootfs
$ cd $HOME/build/rootfs
$ mkdir bin dev etc home lib proc sbin sys tmp usr var
$ mkdir usr/bin usr/lib usr/sbin var/log
$ ln -s lib lib64
```
## Clone And Configure BusyBox
```
$ git clone git://busybox.net/busybox.git --branch 1_36_1 $HOME/git/busybox
$ cd $HOME/git/busybox
$ make defconfig
$ make menuconfig
```
1. `Settings`
    - In `Destination path for 'make install'` Enter `../../build/rootfs`
2. Exit And Save
## Build Root Filesystem
### BeaglePlay
```
$ cd $HOME/git/busybox
$ export ARCH=arm64 CROSS_COMPILE=aarch64-buildroot-linux-gnu-
$ make
$ make install
```
### Copy Shared Libraries
```
$ export SYSROOT=$(aarch64-buildroot-linux-gnu-gcc -print-sysroot)
$ cp -a "$SYSROOT/lib/"*.so* $HOME/build/rootfs/lib/
$ cp -a "$SYSROOT/usr/lib/"*.so* $HOME/build/rootfs/usr/lib/
```
## Create Device Nodes
```
$ cd $HOME/build/rootfs
$ sudo mknod -m 600 dev/console c 5 1 # System Messages, Emergency Logins, And Root Shell Access During Boot Or Single-User Mode
$ sudo mknod -m 666 dev/null c 1 3 # Discard Unwanted Output From Processes Or Provide An Empty Input Stream
```
## Create Example Application
### BeaglePlay
```
$ cd $HOME/build/rootfs
$ cat << 'EOF' > /tmp/application.c
#include <math.h>
#include <stdio.h>
int main(void)
{
    double x = 2.0;
    double y = sqrt(x);
    printf("sqrt(%f) = %f\n", x, y);
    return 0;
}
EOF
$ aarch64-buildroot-linux-gnu-gcc /tmp/application.c -o /tmp/application -lm
$ cp /tmp/application $HOME/build/rootfs/bin/
```
## Create Filesystem Image
```
$ cd $HOME/build
$ echo "/dev d 755 0 0 - - - - -
/dev/console c 600 0 0 5 1 0 0 -
/dev/null c 666 0 0 1 3 0 0 -
/dev/ttyO0 c 600 0 0 252 0 0 0 -" > device-tables.txt
$ genext2fs -b 32768 -d $HOME/build/rootfs -D device-tables.txt -U $HOME/build/rootfs.ext2
```
