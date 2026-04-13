# Buildroot
## Set Up
```
$ mkdir -p $HOME/build/buildroot/custom-application/ $HOME/toolchain/
```
## Download And Install
```
$ wget -P /tmp/ https://buildroot.org/downloads/buildroot-2026.02.tar.xz
$ tar -xvf /tmp/buildroot-2026.02.tar.xz -C $HOME/toolchain/
```
## Create Custom Application
```
$ cat << 'EOF' > $HOME/build/buildroot/custom-application/custom-application.c
#include <stdio.h>
int main(void)
{
    printf("Hello, World!\n");
    return 0;
}
EOF
$ cat << 'EOF' > $HOME/build/buildroot/custom-application/Makefile
custom-application: custom-application.c
	$(CC) -o $@ $^
clean:
	rm custom-application
EOF
$ cat << 'EOF' > $HOME/build/buildroot/custom-application/Config.in
config BR2_PACKAGE_CUSTOM_APPLICATION
	bool "custom-application"
	help
	  A custom Hello World application.
EOF
$ cat << 'EOF' > $HOME/build/buildroot/custom-application/custom-application.mk
CUSTOM_APPLICATION_VERSION = 1.0
CUSTOM_APPLICATION_SITE = $(BR2_EXTERNAL_CUSTOM_PATH)
CUSTOM_APPLICATION_SITE_METHOD = local
define CUSTOM_APPLICATION_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" -C $(@D)
endef
define CUSTOM_APPLICATION_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/custom-application $(TARGET_DIR)/usr/bin
endef
$(eval $(generic-package))
EOF
$ cat << 'EOF' > $HOME/build/buildroot/custom-application/external.desc
name: CUSTOM
desc: Custom applications for embedded Linux
EOF
$ cat << 'EOF' > $HOME/build/buildroot/custom-application/external.mk
include $(BR2_EXTERNAL_CUSTOM_PATH)/custom-application.mk
EOF
$ cd $HOME/toolchain/buildroot-2026.02/
$ make raspberrypi5_defconfig O=$HOME/build/buildroot/ BR2_EXTERNAL=$HOME/build/buildroot/custom-application/
$ echo "BR2_PACKAGE_CUSTOM_APPLICATION=y" >> $HOME/build/buildroot/.config
$ make olddefconfig O=$HOME/build/buildroot/
$ make all O=$HOME/build/buildroot/
```
