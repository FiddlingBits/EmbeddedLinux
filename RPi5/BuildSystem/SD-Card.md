# SD Card
## Bind And Attach SD Card To WSL Using PowerShell Administrator
```
> usbipd list
> usbipd bind --busid [BUS_ID] # Replace BUS_ID With Actual Bus ID
> usbipd attach --wsl --busid [BUS_ID]
```
## Set Up
```
$ lsblk # Get SD Card Device Name
$ SD_CARD=sdg # Replace With Device Name If Different
```
## Buildroot
### Copy Bootloader, Kernel, And Root File System
```
$ sudo docker cp embedded-linux-build-system-rpi5-container:/home/builder/build/buildroot/images/sdcard.img /tmp/
$ sudo dd if=/tmp/sdcard.img of=/dev/$SD_CARD bs=4M status=progress conv=fsync
$ sync
```
## Yocto Project
### Copy Bootloader, Kernel, And Root File System
```
$ FILE=$(sudo docker exec embedded-linux-build-system-rpi5-container sh -c 'ls /home/builder/build/yocto-project/tmp/deploy/images/raspberrypi5/*.rootfs.wic.bz2')
$ sudo docker cp embedded-linux-build-system-rpi5-container:$FILE /tmp/
$ bzcat /tmp/$(basename $FILE) | sudo dd status=progress of=/dev/$SD_CARD
$ sync
```
## Detach And Unbind SD Card From WSL Using PowerShell Administrator
```
> usbipd detach --busid [BUS_ID]
> usbipd unbind --busid [BUS_ID]
```
