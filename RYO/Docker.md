# Embedded Linux
## Build Docker Image
```
$ docker build --no-cache -t embedded-linux-ryo-image .
```
## Create Docker Container
```
$ docker create -it --name embedded-linux-ryo-container embedded-linux-ryo-image
```
## Start Docker Container
```
$ docker start -ai embedded-linux-ryo-container
```
## Exit Docker Container
```
# exit
```
