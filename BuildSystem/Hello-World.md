# Hello World
## Set Up
```
$ mkdir -p $HOME/build/poky/bitbake $HOME/build/poky/toaster/toaster $HOME/git $HOME/python
```
## Clone Poky
```
$ git clone https://git.yoctoproject.org/poky --branch kirkstone $HOME/git/poky
```
## BitBake
### Build QEMU Image
```
$ cd $HOME/git/poky
$ source oe-init-build-env $HOME/build/poky/bitbake
$ bitbake core-image-full-cmdline
```
### Run QEMU Image
```
$ cd $HOME/git/poky
$ source oe-init-build-env $HOME/build/poky/bitbake
$ runqemu qemux86-64 core-image-full-cmdline nographic slirp
```
1. Login as `root`
2. Exit With `poweroff`
## Toaster
### Create Virtual Environment And Install Poky Module
```
$ cd $HOME/python
$ python3 -m venv toaster-venv
$ source toaster-venv/bin/activate
$ cd $HOME/git/poky
$ pip install -r bitbake/toaster-requirements.txt
```
### Build QEMU Image
```
$ cd $HOME/git/poky
$ source oe-init-build-env $HOME/build/poky/bitbake/toaster/toaster
$ source $HOME/python/toaster-venv/bin/activate
$ source toaster start webport=0.0.0.0:8000
```
1. Launch `http://localhost:8000/` Within Web Browser
2. Click `Create your first Toaster project to run manage builds`
3. In `Project name` Enter `toaster-project`
4. In `Release` Select `Yocto Project 4.0 "Kirkstone"`
5. Click `Create project`
6. In `Configuration` Tab Set `Machine` To `qemux86-64` And Save
7. In `Image recipes` Tab Search For `core-image-full-cmdline`
8. Click `Build recipe`
9. Close Webpage When Complete
```
$ source toaster stop
```
### Run QEMU Image
```
$ cd $HOME/git/poky
$ source oe-init-build-env $HOME/build/poky/bitbake/toaster/build-toaster-2
$ runqemu qemux86-64 core-image-full-cmdline nographic slirp
```
1. Login as `root`
2. Exit With `poweroff`
