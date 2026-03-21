# Bootloader
## Set Up
```
$ mkdir -p $HOME/build/beagleplay/a53 $HOME/build/beagleplay/r5 $HOME/git
```
## BeaglePlay
### Build Cortex-R5F U-Boot SPL
```
$ git clone https://github.com/beagleboard/u-boot --branch v2021.01-ti-BeaglePlay-Release $HOME/git/u-boot
$ cd $HOME/git/u-boot
$ export ARCH=arm CROSS_COMPILE=arm-none-eabi-
$ make am62x_evm_r5_defconfig O=$HOME/build/beagleplay/r5
$ make menuconfig O=$HOME/build/beagleplay/r5
```
1. `SPL / TPL`
    - `Support EXT filesystems`
2. `Environment`
    - Select `Environment is in an EXT4 filesystem`
    - Deselect `Environment in an MMC device`
    - In `Name of the block device for the environment` Enter `mmc`
    - In `Device and partition for where to store the environment in EXT4` Enter `1:2`
3. Exit And Save
```
$ make O=$HOME/build/beagleplay/r5
```
### Bundle Cortex-R5F SPL And TIFS Firmware Image
```
$ git clone https://github.com/TexasInstruments/ti-linux-firmware.git --branch 09.00.00.002 $HOME/git/ti-linux-firmware
$ git clone https://github.com/beagleboard/k3-image-gen.git --branch 09.00.00.001 $HOME/git/k3-image-gen
$ cd $HOME/git/k3-image-gen
$ make SOC=am62x SBL=$HOME/build/beagleplay/r5/spl/u-boot-spl.bin SYSFW_PATH=$HOME/git/ti-linux-firmware/ti-sysfw/ti-fs-firmware-am62x-gp.bin
```
### Build Cortex-A53 TF-A
```
$ git clone https://github.com/ARM-software/arm-trusted-firmware.git --branch v2.9 $HOME/git/arm-trusted-firmware
$ cd $HOME/git/arm-trusted-firmware
$ export ARCH=aarch64 CROSS_COMPILE=aarch64-buildroot-linux-gnu-
$ make PLAT=k3 TARGET_BOARD=lite
```
### Build Cortex-A53 U-Boot (SPL, TPL, And Main)
```
$ cd $HOME/git/u-boot
$ export ARCH=aarch64 CROSS_COMPILE=aarch64-buildroot-linux-gnu-
$ make am62x_evm_a53_defconfig O=$HOME/build/beagleplay/a53
$ make menuconfig O=$HOME/build/beagleplay/a53
```
1. `SPL / TPL`
    - `Support EXT filesystems`
2. `Environment`
    - Select `Environment is in an EXT4 filesystem`
    - Deselect `Environment in an MMC device`
    - In `Name of the block device for the environment` Enter `mmc`
    - In `Device and partition for where to store the environment in EXT4` Enter `1:2`
3. Exit And Save
```
$ make ATF=$HOME/git/arm-trusted-firmware/build/k3/lite/release/bl31.bin DM=$HOME/git/ti-linux-firmware/ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f O=$HOME/build/beagleplay/a53
```
