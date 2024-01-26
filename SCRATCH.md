# Build From Scratch
## Toolchain
### Set Up
```
$ git clone https://github.com/crosstool-ng/crosstool-ng.git
$ cd crosstool-ng
$ ./bootstrap
$ ./configure --prefix=${PWD}
$ make
$ make install
$ mkdir -p ~/src/
```
### BeagleBone Black (BBB)
```
$ bin/ct-ng distclean
$ bin/ct-ng arm-cortex_a8-linux-gnueabi
$ bin/ct-ng menuconfig
```
* `Paths and misc options -> Render the toolchain read-only -> Uncheck`
* `Target options -> Use specific FPU -> neon`
* `Target options -> Floating point -> hardware (FPU)`
* `Operating System -> Version of linux -> 6.6.1`
* Exit And Save
```
$ bin/ct-ng build
$ ~/x-tools/arm-cortex_a8-linux-gnueabihf/bin/arm-cortex_a8-linux-gnueabihf-gcc --version
```
### Quick EMUlator (QEMU)
```
$ bin/ct-ng distclean
$ bin/ct-ng arm-unknown-linux-gnueabi
$ bin/ct-ng menuconfig
```
* `Paths and misc options -> Render the toolchain read-only -> Uncheck`
* `Operating System -> Version of linux -> 6.6.1`
* Exit And Save
```
$ bin/ct-ng build
$ ~/x-tools/arm-unknown-linux-gnueabi/bin/arm-unknown-linux-gnueabi-gcc --version
```
### Test
* Create Hello World C Program
```
$ ~/x-tools/arm-cortex_a8-linux-gnueabihf/bin/arm-cortex_a8-linux-gnueabihf-gcc -static -o hello.exe hello.c
$ qemu-arm hello.exe
$ ~/x-tools/arm-unknown-linux-gnueabi/bin/arm-unknown-linux-gnueabi-gcc -static -o hello.exe hello.c
$ qemu-arm hello.exe
```
## Bootloader
### Set Up
```
$ git clone git://git.denx.de/u-boot.git
$ cd u-boot/
```
### BeagleBone Black (BBB)
```
$ export CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf- PATH=${HOME}/x-tools/arm-cortex_a8-linux-gnueabihf/bin/:$PATH
$ make am335x_evm_defconfig
$ make menuconfig
$ make
$ cp MLO u-boot.img ~/scratch/bbb/
```
## Kernel
### Set Up
```
$ git clone https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
$ cd linux
$ git checkout linux-6.1.y
$ make kernelversion
```
### BeagleBone Black (BBB)
```
$ export ARCH=arm CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf- PATH=${HOME}/x-tools/arm-cortex_a8-linux-gnueabihf/bin/:$PATH
$ make mrproper
$ make multi_v7_defconfig
$ make menuconfig
$ make zImage
$ make dtbs
$ cp arch/arm/boot/zImage arch/arm/boot/dts/am335x-boneblack.dtb ~/scratch/bbb/
```
### Quick EMUlator (QEMU)
```
$ export ARCH=arm CROSS_COMPILE=arm-unknown-linux-gnueabi- PATH=${HOME}/x-tools/arm-unknown-linux-gnueabi/bin/:$PATH
$ make mrproper
$ make versatile_defconfig
$ make menuconfig
$ make zImage
$ make dtbs
$ cp arch/arm/boot/zImage arch/arm/boot/dts/versatile-pb.dtb ~/scratch/qemu/
```
## Root File System
### Set Up
```
$ git clone git://busybox.net/busybox.git
$ cd busybox
```
### BeagleBone Black (BBB)
```
$ export CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf- PATH=${HOME}/x-tools/arm-cortex_a8-linux-gnueabihf/bin/:$PATH
$ make distclean
$ make defconfig
$ make menuconfig
$ make
$ make install
$ mkdir -p ~/scratch/bbb/rootfs/
$ cd ~/scratch/bbb/rootfs/
$ mkdir -p bin dev etc home lib proc sbin sys tmp usr var
$ mkdir -p usr/bin usr/lib usr/sbin
$ cp -r ~/git/busybox/_install/* .
$ export SYSROOT=$(arm-cortex_a8-linux-gnueabihf-gcc -print-sysroot)
$ arm-cortex_a8-linux-gnueabihf-readelf -a bin/busybox | grep "program interpreter"
$ ls -al $SYSROOT/lib/ld-linux-armhf.so.3
$ cp -a $SYSROOT/lib/ld-linux-armhf.so.3 lib/
$ arm-cortex_a8-linux-gnueabihf-readelf -a bin/busybox | grep "Shared library"
$ ls -al $SYSROOT/lib/libc.so.6 $SYSROOT/lib/libm.so.6 $SYSROOT/lib/libresolv.so.2
$ cp -a $SYSROOT/lib/libc.so.6 $SYSROOT/lib/libm.so.6 $SYSROOT/lib/libresolv.so.2 lib/
$ ls -al lib/
```
### Quick EMUlator (QEMU)
```
$ cd ~/git/busybox/
$ export CROSS_COMPILE=arm-unknown-linux-gnueabi- PATH=${HOME}/x-tools/arm-unknown-linux-gnueabi/bin/:$PATH
$ make distclean
$ make defconfig
$ make menuconfig
$ make
$ make install
$ mkdir -p ~/scratch/qemu/rootfs/
$ cd ~/scratch/qemu/rootfs/
$ mkdir -p bin dev etc home lib proc sbin sys tmp usr var
$ mkdir -p usr/bin usr/lib usr/sbin
$ cp -r ~/git/busybox/_install/* .
$ export SYSROOT=$(arm-unknown-linux-gnueabi-gcc -print-sysroot)
$ arm-unknown-linux-gnueabi-readelf -a bin/busybox | grep "program interpreter"
$ ls -al $SYSROOT/lib/ld-linux.so.3
$ cp -a $SYSROOT/lib/ld-linux.so.3 lib/
$ arm-unknown-linux-gnueabi-readelf -a bin/busybox | grep "Shared library"
$ ls -al $SYSROOT/lib/libc.so.6 $SYSROOT/lib/libm.so.6 $SYSROOT/lib/libresolv.so.2
$ cp -a $SYSROOT/lib/libc.so.6 $SYSROOT/lib/libm.so.6 $SYSROOT/lib/libresolv.so.2 lib/
$ ls -al lib/
```
## Initial RAM File System (initramfs)
### BeagleBone Black (BBB)
```
$ cd ~/scratch/bbb/rootfs/
$ find . | cpio -H newc -ov --owner root:root > initramfs.cpio
$ gzip initramfs.cpio
$ mkimage -A arm -O linux -T ramdisk -d initramfs.cpio.gz ../uRamdisk
$ rm initramfs.cpio.gz
```
### Quick EMUlator (QEMU)
```
$ cd ~/scratch/qemu/rootfs/
$ find . | cpio -H newc -ov --owner root:root > initramfs.cpio
$ gzip initramfs.cpio
$ mkimage -A arm -O linux -T ramdisk -d initramfs.cpio.gz ../uRamdisk
$ rm initramfs.cpio.gz
```
## Disk Image
### BeagleBone Black (BBB)
```
$ cd ~/scratch/bbb/
$ genext2fs -b 16384 -d rootfs -U rootfs.ext2
```
## SD Card
### Format
```
$ lsblk
$ sudo fdisk /dev/mmcblk0
```
* Delete all partitions with d
* Create boot partition with n, [ENTER], [ENTER], [ENTER], +64M
* Make boot partition bootable with a
* Format boot partition with t, c
* Create root file system partition with n, [ENTER], [ENTER], [ENTER], [ENTER]
* Save with w
```
$ lsblk
$ sudo mkfs.vfat -n BOOT /dev/mmcblk0p1
$ sudo mkfs.ext4 -L ROOTFS /dev/mmcblk0p2
$ ls -l /dev/disk/by-label
```
### Copy
```
$ sudo mkdir -p /mnt/stick/ /mnt/boot/ /mnt/rootfs/
$ lsblk
$ sudo mount /dev/sda1 /mnt/stick/
$ sudo mount /dev/mmcblk0p1 /mnt/boot/
$ sudo cp /mnt/stick/am335x-boneblack.dtb /mnt/stick/MLO /mnt/stick/u-boot.img /mnt/stick/uRamdisk /mnt/stick/zImage /mnt/boot/
$ ls -al /mnt/boot/
$ sudo dd if=/mnt/stick/rootfs.ext2 of=/dev/mmcblk0p2
$ sudo mount /dev/mmcblk0p2 /mnt/rootfs/
$ sudo umount /mnt/stick/ /mnt/boot/ /mnt/rootfs/ 
```
## Boot Initial RAM File System (initramfs)
### BeagleBone Black (BBB)
* Power up BeagleBone with boot button (next to SD card) pressed
* Should see `Trying to boot from MMC1`
* Press any key to enter U-Boot
```
=> version
=> fatload mmc 0:1 0x80200000 zImage
=> fatload mmc 0:1 0x80F00000 am335x-boneblack.dtb
=> fatload mmc 0:1 0x81000000 uRamdisk
=> setenv bootargs console=ttyO0,115200 rdinit=/bin/sh
=> bootz 0x80200000 0x81000000 0x80F00000
# uname -r 
```
* Note, changes made within root file system are lost on reset
### Quick EMUlator (QEMU)
```
$ cd ~/scratch/qemu/
$ QEMU_AUDIO_DRV=none qemu-system-arm -m 256M -nographic -M versatilepb -kernel zImage -append "console=ttyAMA0 rdinit=/bin/sh" -dtb versatile-pb.dtb -initrd uRamdisk
# uname -r
```
* Exit with CTRL+a, release, x
* Note, changes made within root file system are lost on reset
## Boot Disk Image
### BeagleBone Black (BBB)
* Power up BeagleBone with boot button (next to SD card) pressed
* Should see `Trying to boot from MMC1`
* Press any key to enter U-Boot
```
=> version
=> fatload mmc 0:1 0x80200000 zImage
=> fatload mmc 0:1 0x80F00000 am335x-boneblack.dtb
=> setenv bootargs console=ttyO0,115200 root=/dev/mmcblk0p2 rootfstype=ext4 rootwait init=/bin/sh +m rw
=> bootz 0x80200000 - 0x80F00000
# uname -r
```
* Note, changes made within root file system are NOT lost on reset
