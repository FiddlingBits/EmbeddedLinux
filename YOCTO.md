# Yocto
## Set Up
```
$ cd ~/git/
$ git clone git://git.yoctoproject.org/poky.git
$ cd poky
$ git checkout kirkstone
```
## Quick EMUlator (QEMU)
### Build And Boot
```
$ source oe-init-build-env qemu
```
* In `conf/local.conf` remove `#` in front of `MACHINE ?= "qemuarm"`
```
$ bitbake core-image-minimal
$ runqemu help
$ runqemu qemuarm nographic
# uname -r
```
* Log in as `root` with no password
* Exit with CTRL+a, release, x
