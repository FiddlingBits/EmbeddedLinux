# Docker
## Build Image
```
$ docker build --no-cache -t embedded-linux-ryo-rpi5-image .
```
## Create Container
```
$ docker create -it --name embedded-linux-ryo-rpi5-container embedded-linux-ryo-rpi5-image
```
## Start Container
```
$ docker start -ai embedded-linux-ryo-rpi5-container
```
## Exit Container
```
# exit
```
