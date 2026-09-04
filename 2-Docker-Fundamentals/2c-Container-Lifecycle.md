# 2c. Container lifecycle

[← Back to index](../index.md)

## 1. Detaching and attaching

## 2. Visit your container

```
docker container run --name c1 --rm -d nginx:latest
docker container exec c1 cat /etc/nginx/nginx.conf
docker container exec -it c1 sh
```

### 3. Interacting with containers

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

### 6. Debugging the issue from the last assignment

### 7. Becoming PID1

docker image build -t jfahrer/nginx:latest . && docker container run --rm jfahrer/nginx:latest

### 8. Verify it is PID1

### 9. Reading logs

docker container run --rm --name c1 -p 80:80 nginx:latest
curl localhost
docker container run --rm --name c1 -p 80:80 -d nginx:latest
curl localhost
docker container logs c1
docker container logs -f c1
curl localhost

### 10. Producing logs

### 11. Using logfiles

