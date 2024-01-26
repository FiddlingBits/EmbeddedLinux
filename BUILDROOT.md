# Buildroot
## Set Up
```
$ cd ~/git/
$ git clone git://git.buildroot.net/buildroot
$ cd buildroot
$ git checkout 2023.11.x
```
## BeagleBone Black (BBB)
### Build
```
$ cd ~/git/buildroot/
$ sudo make distclean
$ make beaglebone_defconfig
$ make menuconfig
```
* For the following, if PATH contains spaces, TABs, and/or newline characters, sudo must be used
```
$ sudo make
$ cp output/images/am335x-boneblack.dtb output/images/MLO output/images/rootfs.ext2 output/images/u-boot.img output/images/zImage ~/buildroot/bbb/
```
### SD Card
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
$ sudo mkdir -p /mnt/stick/ /mnt/boot/ /mnt/rootfs/
$ sudo mount /dev/sda1 /mnt/stick/
$ sudo mount /dev/mmcblk0p1 /mnt/boot/
$ sudo cp /mnt/stick/am335x-boneblack.dtb /mnt/stick/MLO /mnt/stick/u-boot.img /mnt/stick/zImage /mnt/boot/
$ ls -al /mnt/boot/
$ sudo dd if=/mnt/stick/rootfs.ext2 of=/dev/mmcblk0p2
$ sudo umount /mnt/stick/ /mnt/boot/
```
### Boot
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
## Quick EMUlator (QEMU)
### Build
```
$ cd ~/git/buildroot/
$ sudo make distclean
$ make qemu_arm_versatile_defconfig
$ make menuconfig
```
* For the following, if PATH contains spaces, TABs, and/or newline characters, sudo must be used
```
$ sudo make
$ cp output/images/zImage output/images/versatile-pb.dtb output/images/rootfs.ext2 ~/buildroot/qemu/
```
### Boot
```
$ cd ~/buildroot/qemu/
$ qemu-system-arm -M versatilepb -m 256 -kernel zImage -dtb versatile-pb.dtb -drive file=rootfs.ext2,if=scsi,format=raw -append "root=/dev/sda console=ttyAMA0,115200" -serial stdio -net nic,model=rtl8139 -net user
# uname -r
```
* Log in as `root` with no password
* Note, changes made within root file system are NOT lost on reset
