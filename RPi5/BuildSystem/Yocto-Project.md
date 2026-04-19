# Yocto Project
## Set Up
```
$ mkdir -p $HOME/build/yocto-project/ $HOME/git/
```
## Clone
```
$ git clone git://git.yoctoproject.org/meta-raspberrypi --branch kirkstone $HOME/git/meta-raspberrypi
$ git clone https://git.yoctoproject.org/poky --branch kirkstone $HOME/git/poky
```
## Build
```
$ cd $HOME/git/poky/
$ source oe-init-build-env $HOME/build/yocto-project
$ bitbake-layers add-layer $HOME/git/meta-raspberrypi
$ echo 'DISTRO_FEATURES:append = " systemd"' >> conf/local.conf
$ echo 'VIRTUAL-RUNTIME_init_manager = "systemd"' >> conf/local.conf
$ MACHINE="raspberrypi5" bitbake rpi-test-image
```
## Create Custom Application
```
$ source "$HOME/git/poky/oe-init-build-env" "$HOME/build/yocto-project"
$ bitbake-layers create-layer meta-custom
$ bitbake-layers add-layer meta-custom
$ mkdir -p meta-custom/recipes-example/custom-application/custom-application/ # Warning! Bitbake Interprets Underscores In .bb Filenames As A Name/Version Separator, Use Hyphens Instead.
$ cd meta-custom/recipes-example/custom-application/
$ cat << 'EOF' > custom-application/hello-world.c
#include <stdio.h>
int main(void)
{
    printf("Hello, World!\n");
    return 0;
}
EOF
$ cat << 'EOF' > custom-application/Makefile
hello-world: hello-world.c
	$(CC) -o hello-world hello-world.c -g -Wl,--hash-style=gnu
install:
	install -d $(DESTDIR)/usr/bin/
	install -m 0755 hello-world $(DESTDIR)/usr/bin/hello-world
EOF
$ cat << 'EOF' > custom-application.bb
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""
SRC_URI = "file://hello-world.c file://Makefile"
S = "${WORKDIR}"
FILES_${PN} += "/usr/bin/hello-world"
do_configure () {
        :
}
do_compile () {
        oe_runmake hello-world
}
do_install () {
        oe_runmake install 'DESTDIR=${D}'
}
EOF
$ cd $HOME/build/yocto-project
$ bitbake custom-application
```
## Customize Final Image
```
$ source "$HOME/git/poky/oe-init-build-env" "$HOME/build/yocto-project"
$ mkdir -p meta-custom/recipes-core/images
$ echo 'IMAGE_INSTALL:append = " custom-application"' > meta-custom/recipes-core/images/rpi-test-image.bbappend
$ echo 'IMAGE_INSTALL:append = " dropbear"' >> meta-custom/recipes-core/images/rpi-test-image.bbappend
$ echo 'IMAGE_INSTALL:append = " gdbserver"' >> meta-custom/recipes-core/images/rpi-test-image.bbappend
$ MACHINE="raspberrypi5" bitbake rpi-test-image
$ MACHINE="raspberrypi5" bitbake -c populate_sdk rpi-test-image
```
## Toolchain
### Install
```
$ $HOME/build/yocto-project/tmp/deploy/sdk/poky-glibc-x86_64-rpi-test-image-cortexa76-raspberrypi5-toolchain-*.sh -d $HOME/toolchain/yocto-project/ -y
```
### Verify
```
$ aarch64-poky-linux-gcc --version
```
## Debug Remotely
### Raspberry Pi
```
# gdbserver localhost:12345 hello-world
```
### Docker Container
```
$ cd $HOME/build/yocto-project/meta-custom/recipes-example/custom-application/custom-application/
$ source $HOME/toolchain/yocto-project/environment-setup-cortexa76-poky-linux
$ make
$ aarch64-poky-linux-gdb hello-world
(gdb) target remote 192.168.137.50:12345
(gdb) break main
(gdb) c
(gdb) backtrace
(gdb) q
```
