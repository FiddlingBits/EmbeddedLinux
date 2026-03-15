# Embedded Linux
## Build Docker Image
```
$ docker build --no-cache -t embedded-linux-yocto-image .
```
## Create Docker Container
```
$ docker create -it --name embedded-linux-yocto-container --cap-add=NET_ADMIN --device=/dev/net/tun embedded-linux-yocto-image
```
## Start Docker Container
```
$ docker start -ai embedded-linux-yocto-container
```
## Exit Docker Container
```
# exit
```
