# 2d. Persisting data

[← Back to index](../index.md)

## 1. Introduction

## 2. Mounting data

docker container run --name c1 --rm -v ./tasks/html-files/nginx-html-index/:/var/www/html:ro -p 80:80 mynginx:latest

## 3. The mount option

docker container run --name c1 --rm --mount type=bind,src="./tasks/html-files/nginx-html-index/",destination="/var/www/html",readonly -p 80:80 mynginx:latest

## 4. Volumes

docker container run -it -v /data alpine:latest
df -h
docker volume ls

https://docs.docker.com/engine/storage/volumes/

## 5. Naming volumes

docker container run -it --volume my-volume:/data alpine:latest
touch /data/test.file
docker volume ls
docker container run -it --volume my-volume:/data alpine:latest
ls -l /data
docker container rm -f $(docker container ls -aq) # BEWARE - This command will delete ALL containers on the system
docker container ls -a
docker volume ls

## 6. Using mount for volumes

docker container run -it --mount type=volumne,destination=/data alpine:latest
docker container run -it --mount src=my-volume,destination=/data alpine:latest
docker container run -it --mount src=my-volume,destination=/data,readonly alpine:latest
docker container run -it --mount destination=/data alpine:latest
docker container run -it --mount dst=/data alpine:latest

## 7. Managing volumes

docker container ls -a
docker volume ls
docker volume rm 3587ff1318033bc25a19c8d2e4cbab814d4bf5878fda3b65c2a44d71ca902d0a
docker volume rm my-volume
docker volume inspect my-volume
docker container inspect musing_mclean
docker volume prune
docker volume create other-volume
docker volume ls

## 8. Disappearing volumes

docker container run --rm -v /data alpine:latest echo hello
docker container run --rm -v test-volume:/data alpine:latest echo hello
docker volume ls

## 9. The VOLUMES instruction

## 10. Using volumes from other containers

docker container run --name c1 --rm --volume /data -it alpine:latest
docker container run --volumes-from c1 -it --rm alpine:latest

## 11. Prepopulating volumes

## 12. When to use volumes vs bind