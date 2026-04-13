# SD Card
## Format SD Card With Raspberry Pi Imager
1. Select `OS`, `Raspberry Pi OS (other)`, `Raspberry Pi OS Lite (64-bit)`, And Click `NEXT`
2. Select Storage Device And Click `NEXT`
3. Customize
4. Click `WRITE`
5. Click `I UNDERSTAND, ERASE AND WRITE`
6. When Done Click `FINISH`
## Bind And Attach SD Card To WSL Using PowerShell Administrator
```
> usbipd list
> usbipd bind --busid [BUS_ID] # Replace BUS_ID With Actual Bus ID
> usbipd attach --wsl --busid [BUS_ID]
```
## Edit `config.txt`
1. Add `kernel=u-boot.bin`
## Set Up
```
$ lsblk # Get SD Card Device Name
$ SD_CARD=sdg # Replace With Device Name If Different
```
## Copy Bootloader And Kernel
```
$ sudo mkdir -p /mnt/boot
$ sudo mount /dev/${SD_CARD}1 /mnt/boot
$ sudo docker cp embedded-linux-ryo-rpi5-container:/home/builder/build/bootloader/u-boot.bin /mnt/boot/
$ sudo docker cp embedded-linux-ryo-rpi5-container:/home/builder/build/kernel/arch/arm64/boot/Image /mnt/boot/
$ sync
$ sudo umount /mnt/boot
```
## Copy Root Filesystem
```
$ sudo docker cp embedded-linux-ryo-rpi5-container:/home/builder/build/rootfs.ext2 /tmp/
$ sudo dd if=/tmp/rootfs.ext2 of=/dev/${SD_CARD}2 bs=4M status=progress
$ sync
```
## Detach And Unbind SD Card From WSL Using PowerShell Administrator
```
> usbipd detach --busid [BUS_ID]
> usbipd unbind --busid [BUS_ID]
```
