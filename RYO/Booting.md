# Booting
## Manual
### BeaglePlay
1. Press `USR` Button And Then Power
#### Initial Boot
```
=> setenv bootcmd 'fatload mmc 1 0x80000000 Image.gz; fatload mmc 1 0x82000000 k3-am625-beagleplay.dtb; setenv kernel_comp_addr_r 0x85000000; 
setenv kernel_comp_size 0x20000000; setenv bootargs console=ttyS2,115200n8 root=/dev/mmcblk1p2 rootdelay=5 rootwait; booti 0x80000000 - 0x82000000';
=> saveenv
=> run bootcmd
```
#### Subsequent Boots
```
=> run bootcmd
```
