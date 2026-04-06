# Toolchain
## Set Up
```
$ mkdir -p $HOME/toolchain/
```
## Download And Install
```
$ wget -P /tmp/ https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz
$ tar -xvf /tmp/arm-gnu-toolchain-13.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz -C $HOME/toolchain/
```
## Configure `.bashrc`
```
$ echo 'export PATH="$PATH:$HOME/toolchain/arm-gnu-toolchain-13.3.rel1-x86_64-aarch64-none-linux-gnu/bin/"' >> $HOME/.bashrc
$ source $HOME/.bashrc # Reload
$ echo 'export ARCH=arm64 CROSS_COMPILE=aarch64-none-linux-gnu- SYSROOT=$(aarch64-none-linux-gnu-gcc -print-sysroot)' >> $HOME/.bashrc
$ source $HOME/.bashrc # Reload
```
## Verify
```
$ aarch64-none-linux-gnu-gcc --version
```
