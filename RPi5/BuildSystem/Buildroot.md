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
$ cat << 'EOF' > $HOME/build/buildroot/custom-application/hello-world.c
#include <stdio.h>
int main(void)
{
    printf("Hello, World!\n");
    return 0;
}
EOF
$ cat << 'EOF' > $HOME/build/buildroot/custom-application/Makefile
hello-world: hello-world.c
	$(CC) -o $@ $^ -g
clean:
	rm hello-world
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
	$(INSTALL) -D -m 0755 $(@D)/hello-world $(TARGET_DIR)/usr/bin
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
```
## Build
```
$ cd $HOME/toolchain/buildroot-2026.02/
$ make distclean O=$HOME/build/buildroot/
$ make raspberrypi5_defconfig O=$HOME/build/buildroot/ BR2_EXTERNAL=$HOME/build/buildroot/custom-application/
$ echo "BR2_INIT_SYSTEMD=y" >> $HOME/build/buildroot/.config
$ echo "BR2_PACKAGE_CUSTOM_APPLICATION=y" >> $HOME/build/buildroot/.config
$ echo "BR2_PACKAGE_DROPBEAR=y" >> $HOME/build/buildroot/.config # This And BR2_PACKAGE_HOST_ENVIRONMENT_SETUP Needed For Custom-Application.md
$ echo "BR2_PACKAGE_GDB=y" >> $HOME/build/buildroot/.config
$ echo "BR2_PACKAGE_HOST_ENVIRONMENT_SETUP=y" >> $HOME/build/buildroot/.config
$ echo "BR2_PACKAGE_HOST_GDB=y" >> $HOME/build/buildroot/.config
$ echo 'BR2_STRIP_EXCLUDE_FILES="hello-world"' >> $HOME/build/buildroot/.config
$ make olddefconfig O=$HOME/build/buildroot/
$ make all O=$HOME/build/buildroot/
$ make sdk O=$HOME/build/buildroot/
```
## Toolchain
### Install
```
$ tar -xvf $HOME/build/buildroot/images/aarch64-buildroot-linux-gnu_sdk-buildroot.tar.gz -C $HOME/toolchain/
```
### Configure `.bashrc`
```
$ echo 'export PATH="$PATH:$HOME/toolchain/aarch64-buildroot-linux-gnu_sdk-buildroot/bin/"' >> $HOME/.bashrc
$ source $HOME/.bashrc # Reload
```
### Verify
```
$ aarch64-linux-gcc --version
```
## Debug Remotely
### Raspberry Pi
```
# gdbserver localhost:12345 hello-world
```
### Docker Container
```
$ aarch64-linux-gdb hello-world
(gdb) target remote 192.168.137.50:12345
(gdb) break main
(gdb) c
(gdb) backtrace
(gdb) q
```
