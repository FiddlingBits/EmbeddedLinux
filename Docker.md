# Embedded Linux 
## Build Docker Image
```
$ docker build --no-cache -t embedded-linux-image .
```
## Create Docker Container
```
$ docker create -it --name embedded-linux-container embedded-linux-image
```
## Start Docker Container
```
$ docker start -ai embedded-linux-container
```
## Exit Docker Container
```
# exit
```
