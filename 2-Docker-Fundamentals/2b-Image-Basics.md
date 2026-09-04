# 2b. Image Basics

[← Back to index](../index.md)

## 1. What is an image

Use of container image is to package applications in executable format.

Container is the runtime construct of container image.

## 2. Managing images

```
docker image ls
docker image rm alpine:latest
docker image rm hello-world:latest
docker image pull hello-world:latest
```

## 3. Repositories and tags

```
docker image pull hello-world
docker image pull hello-world:linux
docker image ls
```

## 4. Registries

## 5. Docker Hub

## 6. Creating Images

Task create a Dockerimage file which would contain all the information for our application

"FROM", "RUN", "CMD"

docker image build -t myalpine:latest .

docker container run --rm -it myalpine:latest

## 7. Comments

"#"
Start of the line

## 8. Pushing images

docker image tag myalpine:latest jfahrer/myalpine:latest
docker image push jfahrer/myalpine:latest

## 9. Docker Plugins

