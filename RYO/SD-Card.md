# SD Card
## Bind And Attach SD Card To WSL Using PowerShell Administrator
```
> usbipd list
> usbipd bind --busid [BUS_ID] # Replace BUS_ID With Actual Bus ID
> usbipd attach --wsl --busid [BUS_ID]
```
## Format SD Card Using WSL
```
$ lsblk # Get SD Card Device Name
$ SD_CARD=sdg # Replace With Device Name If Different
$ sudo umount /dev/${SD_CARD}1 /dev/${SD_CARD}2 2>/dev/null
$ sudo dd if=/dev/zero of=/dev/${SD_CARD} bs=1M count=10
$ sudo parted /dev/${SD_CARD} --script mklabel msdos
$ sudo parted /dev/${SD_CARD} --script mkpart primary fat16 1MiB 1025MiB
$ sudo parted /dev/${SD_CARD} --script mkpart primary ext3 1025MiB 100%
$ sudo mkfs.vfat -F 16 -n BOOT /dev/${SD_CARD}1
$ sudo parted /dev/${SD_CARD} set 1 boot on # Mark As Bootable
$ sudo mkfs.ext3 -L ROOTFS /dev/${SD_CARD}2
```
## BeaglePlay
### Copy Bootloader And Kernel
```
$ sudo mkdir -p /mnt/boot
$ sudo mount /dev/${SD_CARD}1 /mnt/boot
$ sudo docker cp embedded-linux-ryo-container:/home/builder/k3-image-gen/tiboot3-am62x-gp-evm.bin /mnt/boot/tiboot3.bin
$ sudo docker cp embedded-linux-ryo-container:/home/builder/build/beagleplay/a53/tispl.bin /mnt/boot
$ sudo docker cp embedded-linux-ryo-container:/home/builder/build/beagleplay/a53/u-boot.img /mnt/boot
$ sudo docker cp embedded-linux-ryo-container:/home/builder/build/beagleplay/kernel/arch/arm64/boot/Image.gz /mnt/boot
$ sudo docker cp embedded-linux-ryo-container:/home/builder/build/beagleplay/kernel/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb /mnt/boot
$ sudo umount /mnt/boot
```
### Copy Root Filesystem
```
$ sudo docker cp embedded-linux-ryo-container:/home/builder/rootfs.ext2 ~/rootfs.ext2
$ sudo dd if=~/rootfs.ext2 of=/dev/${SD_CARD}2 bs=4M status=progress
$ sync
```
## Detach And Unbind SD Card From WSL Using PowerShell Administrator
```
> usbipd detach --busid [BUS_ID]
> usbipd unbind --busid [BUS_ID]
```
