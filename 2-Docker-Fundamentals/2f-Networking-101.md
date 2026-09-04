# 2f. Networking 101

[← Back to index](../index.md)

### 1. Publishing port

`-p host_port:container_port` maps a port on the host to a port inside the container, so traffic sent to the host port is forwarded into the container.

```
docker container run -p 8080:80 nginx:latest
```

### 2. Publishing multiple ports

`-p` can be repeated to publish several ports from the same container:

```
docker container run -p 8080:80 -p 8443:443 nginx:latest
```

### 3. The EXPOSE instruction

`EXPOSE` in a Dockerfile documents which ports the container listens on. It's informational only — it doesn't actually publish the port to the host; `-p`/`-P` is still needed at `run` time.

```
EXPOSE 80
```

### 4. What will be published?

`-p 80` (no host port given) publishes container port 80 on a random available host port. `-P` publishes all ports declared via `EXPOSE` in the image, each to a random host port.

```
docker container run -p 80 nginx:latest
docker container run -P nginx:latest
```

### 5. Links

`--link` is a legacy mechanism for connecting containers on the default bridge network, letting one container resolve another by name. It's one-directional and considered deprecated in favor of user-defined networks (below).

### 6. User defined networks

Creating a custom network lets containers attached to it resolve each other by name via Docker's embedded DNS, in both directions — unlike the default bridge network.

```
docker network ls
docker network create mynet
docker network ls
docker container run --network mynet --rm -it alpine:latest
docker network rm mynet
```

### 7. Resolving hostnames

Containers on the same user-defined network can `ping`/connect to each other using their `--name` as a hostname. A static IP can also be assigned with `--ip` (network must support the requested subnet).

```
docker container run --network mynet --name c1 --rm -it alpine:latest
docker container run --network mynet --name c2 --rm -it alpine:latest
docker container run --network mynet --name c2 --rm -it --ip 172.18.0.99 alpine:latest
```

### 8. User defined networks and links

On a user-defined network, `--link` can also add an alias for a container (`--link postgres:pg`), so it's reachable under both its real name and the alias.

```
docker container run --network mynet --name postgres --rm -d postgres:9.6.6-alpine
docker container run --network mynet -it --rm --link postgres:pg alpine:latest
ping postgres
ping pg
```

### 9. Sharing names

`--network-alias` lets multiple containers share the same DNS name on a network. Resolving that name returns all matching containers' IPs (basic round-robin-style DNS), useful for simple load balancing across replicas.

```
docker container run -d --network mynet --network-alias webserver nginx:latest
docker container run -d --network mynet --network-alias webserver nginx:latest
docker container run -d --network mynet --network-alias webserver nginx:latest
docker container run --network mynet -it alpine:latest
nslookup webserver
```
