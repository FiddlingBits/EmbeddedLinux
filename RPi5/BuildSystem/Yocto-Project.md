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
$ MACHINE="raspberrypi5" bitbake rpi-test-image
```
## Create Custom Application
```
$ source "$HOME/git/poky/oe-init-build-env" "$HOME/build/yocto-project"
$ bitbake-layers create-layer meta-custom
$ bitbake-layers add-layer meta-custom
$ mkdir -p meta-custom/recipes-example/custom-application/custom-application/ # Warning! Bitbake Interprets Underscores In .bb Filenames As A Name/Version Separator, Use Hyphens Instead.
$ cd meta-custom/recipes-example/custom-application/
$ cat << 'EOF' > custom-application/custom-application.c
#include <stdio.h>
int main(void)
{
    printf("Hello, World!\n");
    return 0;
}
EOF
$ echo -e 'custom_application:\n\t$(CC) -o custom_application custom-application.c -Wl,--hash-style=gnu\ninstall:\n\tinstall -d $(DESTDIR)/usr/bin/\n\tinstall -m 0755 custom_application $(DESTDIR)/usr/bin/custom-application' > custom-application/Makefile
$ cat << 'EOF' > custom-application.bb
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""
SRC_URI = "file://custom-application.c file://Makefile"
S = "${WORKDIR}"
FILES_${PN} += "/usr/bin/custom-application"
do_configure () {
        :
}
do_compile () {
        oe_runmake custom_application
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
$ MACHINE="raspberrypi5" bitbake rpi-test-image
```
