# Kernel
## Download
```
$ cd ~
$ wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.6.129.tar.xz
$ tar xf linux-6.6.129.tar.xz
$ rm linux-6.6.129.tar.xz # Clean Up
```
## Build
### BeaglePlay
```
$ cd ~
$ cd linux-6.6.129/
$ mkdir -p ../build/beagleplay/kernel
$ export ARCH=arm64
$ export CROSS_COMPILE=aarch64-buildroot-linux-gnu-
$ make defconfig O=../build/beagleplay/kernel
$ make menuconfig O=../build/beagleplay/kernel
```
1. `General architecture-dependent options`
    - Deselect `GCC plugins`
2. `Platform selection`
    - Deselect Everything Except `Texas Instruments Inc. K3 multicore SoC architecture`
3. `Device Drivers`
    - `Graphics support`
        - Deselect `Direct Rendering Manager`
4. Exit And Save
```
$ make O=../build/beagleplay/kernel
```
