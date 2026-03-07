# Bootloader
## BeaglePlay
### Build Cortex-R5F U-Boot SPL
```
$ cd ~
$ git clone https://github.com/beagleboard/u-boot
$ cd u-boot
$ git checkout f036fb
$ mkdir -p ../build/beagleplay/r5
$ export ARCH=arm
$ export CROSS_COMPILE=arm-none-eabi-
$ make am62x_evm_r5_defconfig O=../build/beagleplay/r5
$ make menuconfig O=../build/beagleplay/r5
```
1. `Boot options`
    - Select `Enable a default value for bootcmd`
    - Enter `echo 'no bootcmd yet'` In bootcmd value
2. `Environment`
    - Select `Environment is in a EXT4 filesystem`
    - Deselect `Environment in an MMC device`
    - Enter `mmc` In `Name of the block device for the environment`
    - Enter `1:2` In `Device and partition for where to store the environment in EXT4`
3. `SPL / TPL`
    - `Support EXT filesystems`
4. Exit And Save
```
$ make O=../build/beagleplay/r5
```
### Bundle Cortex-R5F SPL And TIFS Firmware Image
```
$ cd ~
$ git clone https://github.com/TexasInstruments/ti-linux-firmware.git
$ cd ti-linux-firmware
$ git checkout 09.00.00.002
$ cd ~
$ git clone https://github.com/beagleboard/k3-image-gen.git
$ cd k3-image-gen
$ git checkout 09.00.00.001
$ make SOC=am62x SBL=../build/beagleplay/r5/spl/u-boot-spl.bin SYSFW_PATH=../ti-linux-firmware/ti-sysfw/ti-fs-firmware-am62x-gp.bin
```
### Build Cortex-A53 TF-A
```
# cd ~
# git clone https://github.com/ARM-software/arm-trusted-firmware.git
# cd arm-trusted-firmware
# git checkout v2.9
# export ARCH=aarch64
# export CROSS_COMPILE=aarch64-buildroot-linux-gnu-
# make PLAT=k3 TARGET_BOARD=lite
```
### Build Cortex-A53 U-Boot (SPL, TPL, And Main)
```
$ cd ~
$ cd u-boot
$ mkdir -p ../build/beagleplay/a53
$ export ARCH=aarch64
$ export CROSS_COMPILE=aarch64-buildroot-linux-gnu-
$ make am62x_evm_a53_defconfig O=../build/beagleplay/a53
$ make menuconfig O=../build/beagleplay/a53
```
1. `Boot options`
    - Select `Enable a default value for bootcmd`
    - Enter `echo 'no bootcmd yet'` In bootcmd value
2. `Environment`
    - Select `Environment is in a EXT4 filesystem`
    - Deselect `Environment in an MMC device`
    - Enter `mmc` In `Name of the block device for the environment`
    - Enter `1:2` In `Device and partition for where to store the environment in EXT4`
3. `SPL / TPL`
    - `Support EXT filesystems`
4. Exit And Save
```
$ make ATF=$HOME/arm-trusted-firmware/build/k3/lite/release/bl31.bin DM=$HOME/ti-linux-firmware/ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f O=../build/beagleplay/a53
```
