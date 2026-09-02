# Everything in 2nd module: Docker Fundamentals

## A. Getting started

### 1. Running your first container

Input:

```
docker container run hello-world
```

Output:

```
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
58dee6a49ef1: Pull complete 
c3bdf82c34d1: Download complete 
Digest: sha256:5dd0d3e6e255913fc30f90b9f2b1d359cc2cbdb48090cc4b65f1676e203243cc
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (arm64v8)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```


This will first search for hello-world image locally
If it exists than it will run a container for this image
if it doesn't exists than it will call the docker deamon, fetch the hello-world image from the docker hub
Than it will create a container for this image and then run it.

### 2. Starting a shell

To run a shell we'll start with alpine image.
Alpine represents the minimum required linux image
we'll use the `-it` for interactively running the image
we'll add the `sh` at the end for shell 

Input:

```
docker container run -it alpine sh
```

### 3. Finding images

Images can be found inside the "hub.docker.com"
Task: Pull a linux distribution known to you and start an interactive shell command

### 4. Letting things run

When doing CTRL + D you quit the current container but if you want to keep running the current container and come back to it than you do: CTRL + PQ. NOTE: this only works if you start the container using the `-it` flags

Running containers can be checked by using the command:
```
docker container ls
```

You can reattach to the container using the command:
```
docker container attach {container_name}
```

To check all the containers exited and running, you can use the command:
```
docker container ls -a
```

You can start previously closed container using the command:
```
docker container start {container_name}
```

You can close the running container using the command:
```
docker container stop {container_name}
```

You can start the container in detach mode using the `-d` flag
```
docker container run -itd alpine sh
```

### 5. Cleaning things up

Previously created containers are still on our containers even if they are closed. So we'll clean them up now using:
```
docker container rm {container_id}
```

For fetching all the containers id we can run the following command:
```
docker container ls -aq
```

If using bash shell we can run the following command to fetch all the container id and pass it to the rm command:
```
docker container rm $(docker container ls -aq)
```

To fetch all the docker images that we have on our computer we use the command:
```
docker image ls
```

To remove any image from the computer we use the command:
```
docker image rm {image_name}
```

Docker will avoid you from removing the images that are in use, same for containers as well.