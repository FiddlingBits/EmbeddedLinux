# Toolchain
## BeaglePlay
### Set Up
```
$ mkdir -p $HOME/toolchain
```
### Download And Install 32-Bit Toolchain For Cortex-R5F U-Boot (SPL)
```
$ wget -P "$HOME" https://developer.arm.com/-/media/Files/downloads/gnu/15.2.rel1/binrel/arm-gnu-toolchain-15.2.rel1-x86_64-arm-none-eabi.tar.xz
$ tar -xvf $HOME/arm-gnu-toolchain-15.2.rel1-x86_64-arm-none-eabi.tar.xz -C $HOME/toolchain
$ rm $HOME/arm-gnu-toolchain-15.2.rel1-x86_64-arm-none-eabi.tar.xz # Clean Up
```
### Download And Install 64-Bit Toolchain For Cortex-A53 TF-A, U-Boot (SPL, TPL, And Main), And Linux Kernel
```
$ wget -P "$HOME" https://toolchains.bootlin.com/downloads/releases/toolchains/aarch64/tarballs/aarch64--glibc--stable-2025.08-1.tar.xz
$ tar -xvf $HOME/aarch64--glibc--stable-2025.08-1.tar.xz -C $HOME/toolchain
$ rm $HOME/aarch64--glibc--stable-2025.08-1.tar.xz # Clean Up
```
### Configure Path
```
$ echo 'export PATH="$PATH:/home/builder/toolchain/arm-gnu-toolchain-15.2.rel1-x86_64-arm-none-eabi/bin:/home/builder/toolchain/aarch64--glibc--stable-2025.08-1/bin"' >> $HOME/.bashrc
$ source $HOME/.bashrc # Reload
```
### Verify
```
$ arm-none-eabi-gcc --version
$ aarch64-buildroot-linux-gnu-gcc --version
```
