# 2d. Persisting data

[← Back to index](../index.md)

## 1. Introduction

Containers are ephemeral — data written inside a container's writable layer is lost when the container is removed. To persist data (or share it with the host/other containers), Docker offers bind mounts and volumes.

## 2. Mounting data

A bind mount maps a path on the host filesystem directly into the container. `:ro` makes it read-only inside the container.

```
docker container run --name c1 --rm -v ./tasks/html-files/nginx-html-index/:/var/www/html:ro -p 80:80 mynginx:latest
```

## 3. The mount option

`--mount` is the more explicit, verbose alternative to `-v`/`--volume` — same result, but each part (`type`, `src`, `destination`, `readonly`) is a named key instead of a positional colon-separated string.

```
docker container run --name c1 --rm --mount type=bind,src="./tasks/html-files/nginx-html-index/",destination="/var/www/html",readonly -p 80:80 mynginx:latest
```

## 4. Volumes

A volume is storage managed by Docker itself (outside any container's filesystem), rather than a path on the host. Running with `-v /data` and no source creates an anonymous volume mounted at `/data`.

```
docker container run -it -v /data alpine:latest
df -h
docker volume ls
```

https://docs.docker.com/engine/storage/volumes/

## 5. Naming volumes

Giving a volume a name (`-v my-volume:/data`) lets it be reused across multiple containers, since Docker resolves it by name instead of generating a random one each time.

```
docker container run -it --volume my-volume:/data alpine:latest
touch /data/test.file
docker volume ls
docker container run -it --volume my-volume:/data alpine:latest
ls -l /data
docker container rm -f $(docker container ls -aq) # BEWARE - This command will delete ALL containers on the system
docker container ls -a
docker volume ls
```

## 6. Using mount for volumes

`--mount` works for named volumes the same way it does for bind mounts, just with `src` pointing at the volume name instead of a host path.

```
docker container run -it --mount type=volumne,destination=/data alpine:latest
docker container run -it --mount src=my-volume,destination=/data alpine:latest
docker container run -it --mount src=my-volume,destination=/data,readonly alpine:latest
docker container run -it --mount destination=/data alpine:latest
docker container run -it --mount dst=/data alpine:latest
```

## 7. Managing volumes

Volumes exist independently of containers, so they need to be inspected/removed separately. `docker volume prune` removes all volumes not currently used by any container.

```
docker container ls -a
docker volume ls
docker volume rm 3587ff1318033bc25a19c8d2e4cbab814d4bf5878fda3b65c2a44d71ca902d0a
docker volume rm my-volume
docker volume inspect my-volume
docker container inspect musing_mclean
docker volume prune
docker volume create other-volume
docker volume ls
```

## 8. Disappearing volumes

Anonymous volumes created without `--rm`-aware cleanup can pile up, since removing the container doesn't automatically remove the volumes it used (unless `docker container rm -v` is used). Named volumes persist independently of any container's lifecycle, which is what makes them safe for durable data.

```
docker container run --rm -v /data alpine:latest echo hello
docker container run --rm -v test-volume:/data alpine:latest echo hello
docker volume ls
```

## 9. The VOLUMES instruction

The Dockerfile `VOLUME` instruction declares that a path should be a mount point, causing Docker to automatically create an anonymous volume there for any container started from the image (if nothing else is mounted at that path):

```
VOLUME /data
```

## 10. Using volumes from other containers

`--volumes-from` copies all volume mounts from another container into the new one, an easy way to share data between containers without knowing the exact volume names.

```
docker container run --name c1 --rm --volume /data -it alpine:latest
docker container run --volumes-from c1 -it --rm alpine:latest
```

## 11. Prepopulating volumes

When a volume is mounted into a container at a path that already contains files from the image, and the volume is empty, Docker copies the image's existing files into the volume first. This lets a fresh named volume start out "prepopulated" with the image's default data.

## 12. When to use volumes vs bind

- **Bind mounts** — best for local development, when you want to edit files on the host and see changes reflected live in the container, or expose specific host files/directories.
- **Volumes** — best for production/persistent data (databases, uploads), since they're managed by Docker, portable across hosts, and don't depend on a particular host directory layout.
