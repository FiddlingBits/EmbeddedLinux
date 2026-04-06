# Booting
## Raspberry Pi 5
### Initial Boot
```
=> setenv bootcmd 'fatload mmc 0:1 0x80000 Image; fatload mmc 0:1 0x1f00000 bcm2712-rpi-5-b.dtb; setenv bootargs "console=ttyAMA10,115200 root=/dev/mmcblk0p2 rw rootwait"; booti 0x80000 - 0x1f00000;'
=> saveenv
=> run bootcmd
```
