# 2e. Data in images

[← Back to index](../index.md)

### 1. Publishing port

### 2. Publishing multiple ports

### 3. The EXPOSE instruction

### 4. What will be published?

docker container run -p 80 nginx:latest
docker container run -P nginx:latest

### 5. Links

### 6. User defined networks

docker network ls
docker network create mynet
docker network ls
docker container run --network mynet --rm -it alpine:latest
docker network rm mynet

### 7. Resolving hostnames

docker container run --network mynet --name c1 --rm -it alpine:latest
docker container run --network mynet --name c2 --rm -it alpine:latest
docker container run --network mynet --name c2 --rm -it --ip 172.18.0.99 alpine:latest

### 8. User defined networks and links

docker container run --network mynet --name postgres --rm -d postgres:9.6.6-alpine
docker container run --network mynet -it --rm --link postgres:pg alpine:latest
ping postgres
ping pg

### 9. Sharing names

docker container run -d --network mynet --network-alias webserver nginx:latest
docker container run -d --network mynet --network-alias webserver nginx:latest
docker container run -d --network mynet --network-alias webserver nginx:latest
docker container run --network mynet -it alpine:latest
nslookup webserver