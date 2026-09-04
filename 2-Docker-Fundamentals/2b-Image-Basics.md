# 2b. Image Basics

[← Back to index](../index.md)

## 1. What is an image

Use of container image is to package applications in executable format.

Container is the runtime construct of container image.

An image is a read-only template made up of layers; a container is a running (writable) instance created from that image.

## 2. Managing images

Basic commands for listing, removing and pulling images:

```
docker image ls
docker image rm alpine:latest
docker image rm hello-world:latest
docker image pull hello-world:latest
```

## 3. Repositories and tags

An image name is made up of a repository and a tag, separated by `:` (e.g. `hello-world:linux`). If no tag is given, Docker defaults to `latest`. A repository can have many tags pointing at different image versions.

```
docker image pull hello-world
docker image pull hello-world:linux
docker image ls
```

## 4. Registries

A registry is a server that stores and distributes images, organized into repositories. Docker Hub is the default public registry, but registries can also be private (self-hosted or cloud-provider, e.g. ECR, GCR, ACR). The registry can be included in the image name, e.g. `myregistry.com/myuser/myimage:latest`; if omitted, Docker assumes Docker Hub.

## 5. Docker Hub

Docker Hub (hub.docker.com) is Docker's default public registry. It hosts official images (maintained by Docker/vendors, e.g. `nginx`, `alpine`, `postgres`) as well as user/organization images. A free account lets you push your own images to public (or limited private) repositories; `docker login` authenticates the CLI against it.

## 6. Creating Images

Task create a Dockerimage file which would contain all the information for our application

Images are built from a `Dockerfile` describing the steps needed to produce it. Key instructions:

- `FROM` — the base image to build on top of
- `RUN` — executes a command at build time, creating a new layer
- `CMD` — the default command to run when a container starts from the image

```
docker image build -t myalpine:latest .

docker container run --rm -it myalpine:latest
```

## 7. Comments

"#"
Start of the line

Any line in a Dockerfile starting with `#` is treated as a comment and ignored by the build.

## 8. Pushing images

To push an image to a registry it must be tagged with the target repository name (including the registry/namespace). You also need to be logged in (`docker login`) with permission to write to that repository.

```
docker image tag myalpine:latest jfahrer/myalpine:latest
docker image push jfahrer/myalpine:latest
```

## 9. Docker Plugins

Plugins extend the Docker Engine with extra functionality, most commonly volume drivers (e.g. for cloud storage) and network drivers, but also authorization/logging plugins. They're managed with the `docker plugin` command:

```
docker plugin ls
docker plugin install <plugin-name>
```
