# 2c. Container lifecycle

[← Back to index](../index.md)

## 1. Detaching and attaching

A container started with `-it` can be detached from (leaving it running) with `CTRL + P, Q`, and reattached to later with `docker container attach {container_name}`. Detaching is different from exiting — `CTRL + D` or `exit` stops the container's main process, ending it.

## 2. Visit your container

`docker container exec` runs an additional command inside an already-running container, without affecting its main process.

```
docker container run --name c1 --rm -d nginx:latest
docker container exec c1 cat /etc/nginx/nginx.conf
docker container exec -it c1 sh
```

### 3. Interacting with containers

`-i` keeps STDIN open (interactive), `-t` allocates a pseudo-TTY. Both are usually combined as `-it` to get a usable interactive shell; without them, input/output doesn't behave like a normal terminal session.

`-i` `-t`

```
docker container run -i alpine
ls -l
docker container run -t alpine
ls -l
docker container run -it alpine
ls -l
```

### 4. Stopping a container

`docker container stop` sends `SIGTERM` to the container's PID 1 process, giving it a chance to shut down gracefully, then sends `SIGKILL` if it hasn't exited after a timeout. `docker container kill` sends `SIGKILL` (or another signal via `--signal`) immediately, with no grace period.

SIGTERM, SIGINT, PID

```
docker container run --name c1 nginx:latest
docker container stop c1
docker container ls -a
docker container run --name c2 jfahrer/stop_demo:latest
docker container stop c2
docker container run --name c3 jfahrer/stop_demo:latest
docker container kill c3
docker container kill --help
```

### 5. The end of containers

A container ends when its PID 1 process exits, whether that's because the command finished, it crashed, or it was stopped/killed. The container itself (its filesystem layer, metadata, logs) still exists afterwards until it's removed with `docker container rm`.

### 6. Debugging the issue from the last assignment

If a container doesn't stop gracefully with `docker container stop`, it usually means the process running as PID 1 doesn't handle/forward `SIGTERM` — a common issue for processes started via a shell script wrapper instead of directly.

### 7. Becoming PID1

For an app to receive `SIGTERM`/`SIGINT` directly and shut down cleanly, it needs to run as PID 1 in the container (e.g. via the Dockerfile's `CMD`/`ENTRYPOINT` running the binary directly, not through an intermediate shell script).

```
docker image build -t jfahrer/nginx:latest . && docker container run --rm jfahrer/nginx:latest
```

### 8. Verify it is PID1

Exec into the running container and check the process list — the app should be listed as PID 1:

```
docker container exec <container> ps aux
```

### 9. Reading logs

Docker captures whatever a container's process writes to STDOUT/STDERR as its logs. `docker container logs` prints them; `-f` follows the log output live, similar to `tail -f`.

```
docker container run --rm --name c1 -p 80:80 nginx:latest
curl localhost
docker container run --rm --name c1 -p 80:80 -d nginx:latest
curl localhost
docker container logs c1
docker container logs -f c1
curl localhost
```

### 10. Producing logs

Applications should log to STDOUT/STDERR rather than to files inside the container, so Docker's logging driver can capture, rotate, and forward them consistently (e.g. to `docker container logs` or an external log collector).

### 11. Using logfiles

If an application only writes to a log file inside the container, that file isn't picked up by `docker container logs`. Workarounds include configuring the app to log to STDOUT, or mounting/tailing the log file via a volume from outside the container.
