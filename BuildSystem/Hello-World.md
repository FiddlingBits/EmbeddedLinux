# Hello World
## Build QEMU Image
```
$ cd ~
$ git clone https://git.yoctoproject.org/poky
$ cd poky
$ git checkout kirkstone
$ mkdir -p ../build/qemu/poky
$ source oe-init-build-env ../build/qemu/poky/
$ ls -al ~/poky/meta*/recipes*/*images/*.bb  # List Available Images
$ bitbake core-image-full-cmdline
```
## Run QEMU Image
```
$ cd ~
$ cd poky
$ source oe-init-build-env ../build/qemu/poky/
$ runqemu qemux86-64 core-image-full-cmdline nographic slirp
```
1. Login as `root`
2. Exit With `poweroff`

