# Toolchain
## BeaglePlay
### Set Up
```
$ cd ~
$ mkdir -p toolchain
```
### Download And Install 32-Bit Toolchain For Cortex-R5F U-Boot (SPL)
```
$ wget https://developer.arm.com/-/media/Files/downloads/gnu/15.2.rel1/binrel/arm-gnu-toolchain-15.2.rel1-x86_64-arm-none-eabi.tar.xz
$ tar -xvf arm-gnu-toolchain-15.2.rel1-x86_64-arm-none-eabi.tar.xz -C /home/builder/toolchain
$ rm arm-gnu-toolchain-15.2.rel1-x86_64-arm-none-eabi.tar.xz # Clean Up
```
### Download And Install 64-Bit Toolchain For Cortex-A53 TF-A, U-Boot (SPL, TPL, And Main), And Linux Kernel
```
$ wget https://toolchains.bootlin.com/downloads/releases/toolchains/aarch64/tarballs/aarch64--glibc--stable-2025.08-1.tar.xz
$ tar -xvf aarch64--glibc--stable-2025.08-1.tar.xz -C /home/builder/toolchain
$ rm aarch64--glibc--stable-2025.08-1.tar.xz # Clean Up
```
### Configure Path
```
$ echo 'export PATH="$PATH:/home/builder/toolchain/arm-gnu-toolchain-15.2.rel1-x86_64-arm-none-eabi/bin:/home/builder/toolchain/aarch64--glibc--stable-2025.08-1/bin"' >> ~/.bashrc
$ source ~/.bashrc # Reload
```
### Verify
```
$ arm-none-eabi-gcc --version
$ aarch64-buildroot-linux-gnu-gcc --version
```
