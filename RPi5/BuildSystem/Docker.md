# Embedded Linux
## Build Image
```
$ docker build --no-cache -t embedded-linux-build-system-rpi5-image .
```
## Create Container
```
$ docker create -it --name embedded-linux-build-system-rpi5-container embedded-linux-build-system-rpi5-image
```
## Start Container
```
$ docker start -ai embedded-linux-build-system-rpi5-container
```
## Exit Container
```
# exit
```
