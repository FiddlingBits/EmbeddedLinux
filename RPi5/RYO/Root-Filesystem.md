# Root File System
## Set Up
```
$ mkdir -p $HOME/build/rootfs/
``` 
## Create Staging Directory
```
$ cd $HOME/build/rootfs/
$ mkdir -p bin dev etc home lib proc sbin sys tmp usr/bin usr/lib usr/modules usr/sbin var/log
$ ln -s lib lib64
```
## Build
```
$ cd $HOME/git/busybox/
$ make defconfig
$ $HOME/git/linux/scripts/config --file .config --set-str CONFIG_PREFIX "$HOME/build/rootfs/"
$ make
$ make install
```
## Copy Shared Libraries
```
$ cp -a $SYSROOT/lib/*.so* $HOME/build/rootfs/lib/
$ cp -a $SYSROOT/lib64/. $HOME/build/rootfs/lib/
$ cp -a $SYSROOT/usr/lib/*.so* $HOME/build/rootfs/usr/lib/
```
## Create Device Nodes
```
$ cd $HOME/build/rootfs/
$ sudo mknod -m 600 dev/console c 5 1 # System Messages, Emergency Logins, And Root Shell Access During Boot Or Single-User Mode
$ sudo mknod -m 666 dev/null c 1 3 # Discard Unwanted Output From Processes Or Provide An Empty Input Stream
```
## Create And Compile Custom Example Application
```
$ cat << 'EOF' > /tmp/custom_application.c
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
$ aarch64-none-linux-gnu-gcc /tmp/custom_application.c -o /tmp/custom_application -lm
$ cp /tmp/custom_application $HOME/build/rootfs/bin/
```
## Create Custom Module
```
$ echo "obj-m += custom_module.o" > /tmp/Makefile
$ cat << 'EOF' > /tmp/custom_module.c
#include <linux/init.h>
#include <linux/module.h>
static void __exit custom_module_exit(void)
{
    printk(KERN_INFO "Goodbye World!\n");
}
static int __init custom_module_init(void)
{
    printk(KERN_INFO "Hello World!\n");
    return 0;
}
module_exit(custom_module_exit);
module_init(custom_module_init);
MODULE_AUTHOR("Paul E. Dunn");
MODULE_DESCRIPTION("Hello World Kernel Module");
MODULE_LICENSE("GPL");
EOF
$ make -C "$HOME/git/linux" O="$HOME/build/kernel" M="/tmp" modules
$ cp /tmp/custom_module.ko $HOME/build/rootfs/usr/modules/
```
## Create Filesystem Image
```
$ echo "/dev d 755 0 0 - - - - -
/dev/console c 600 0 0 5 1 0 0 -
/dev/null c 666 0 0 1 3 0 0 -
/dev/ttyAMA10 c 600 0 0 204 74 0 0 -" > /tmp/device-tables.txt
$ genext2fs -b 524288 -d $HOME/build/rootfs/ -D /tmp/device-tables.txt -U $HOME/build/rootfs.ext2
```
