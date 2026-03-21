# Kernel
## Set Up
```
$ mkdir -p $HOME/build/beagleplay/kernel
```
## Download
```
$ wget -P "$HOME" https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.6.129.tar.xz
$ tar -xvf $HOME/linux-6.6.129.tar.xz -C $HOME
$ rm $HOME/linux-6.6.129.tar.xz # Clean Up
```
## Build
### BeaglePlay
```
$ cd $HOME/linux-6.6.129/
$ export ARCH=arm64 CROSS_COMPILE=aarch64-buildroot-linux-gnu-
$ make defconfig O=$HOME/build/beagleplay/kernel
$ make menuconfig O=$HOME/build/beagleplay/kernel
```
1. `Platform selection`
    - Deselect Everything Except `Texas Instruments Inc. K3 multicore SoC architecture`
2. `General architecture-dependent options`
    - Deselect `GCC plugins`
3. `Device Drivers`
    - `Graphics support`
        - Deselect `Direct Rendering Manager`
4. Exit And Save
```
$ make O=$HOME/build/beagleplay/kernel
```
