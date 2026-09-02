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

### 6. Hints

Sometimes once any docker container completes the process, we don't need it around so we use the `--rm` flag after run to remove the container once it is used.

```
docker container run --rm hello-world
```

We can provide our own name to the containers using the `--name` flag.

```
docker container run --name my_container1 hello-world
```

### 7. Publishing a service

There would times when we are either hosting a server or a service and we would have request coming in our docker container so we would connect the machine port with the port exposed in the container for this we would do below task:

Run a nginx server with `-p` flag which allows us to specify a port that would define the port exposed in container as well as local machine. Here the first "80" represents the local machine port and the second "80" represents the container port to connect
```
docker container run -p 80:80 nginx
```

After this when you would visit the localhost on the browser, you could see following in our container logs:
```
192.168.65.1 - - [02/Sep/2026:17:50:49 +0000] "GET / HTTP/1.1" 200 896 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36" "-"
192.168.65.1 - - [02/Sep/2026:17:50:49 +0000] "GET /favicon.ico HTTP/1.1" 404 555 "http://localhost/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36" "-"
2026/09/02 17:50:49 [error] 29#29: *2 open() "/usr/share/nginx/html/favicon.ico" failed (2: No such file or directory), client: 192.168.65.1, server: localhost, request: "GET /favicon.ico HTTP/1.1", host: "localhost", referrer: "http://localhost/"
```

### 8. Data in containers

We will now serve a static html file in our nginx server. For this we would start with creating a directory with a index.html file and then pass this directory to ngnix container to store and serve.

We would do this following command also provided by nginx offical documentation on docker hub
```
docker container run -p 80:80 -v /Users/julian/workspace/docker_examples/html:/usr/share/nginx/html nginx
```

### 9. Isolation

By default every container is isolated, it gets its own network namespace/stack, so it cannot see or reach other containers unless we explicitly connect them.

We can check this by starting two alpine containers and trying to ping one from the other, it will fail since they aren't on a shared network yet:
```
docker container run -it --rm --name c1 alpine sh
docker container run -it --rm --name c2 alpine sh
```

Inside `c2`, pinging `c1` by name won't resolve, since docker only does name resolution for containers on the same user defined network (default bridge network doesn't support it).

### 10. Container communication

One (legacy) way to let two containers talk to each other is the `--link` flag, it lets a new container reach another existing container by name.

```
docker container run -itd --name c1 alpine sh
docker container run -it --rm --link c1 --name c2 alpine sh
```

Now from inside `c2` we can `ping c1` and it resolves. `--link` is considered a legacy feature though, since it only works one way (c2 knows about c1, not the other way around) and is scoped to the default bridge network. User defined networks (below) are the recommended way to do this now.

### 11. User defined networks

Creating our own network lets any container attached to it resolve the others by container name automatically, in both directions.

```
docker network ls
docker network create test
docker container run -it --rm --network test --name c1 alpine sh
```

If we start a second container on the same network:
```
docker container run -it --rm --network test --name c2 alpine sh
```

Then `c1` and `c2` can ping each other by name, since docker's embedded DNS resolves container names to their IP within the same user defined network.

We can inspect a network to see which containers are attached and their IPs:
```
docker network inspect test
```

And remove a network once we're done with it (all containers using it must be stopped/removed first):
```
docker network rm test
```