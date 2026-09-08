# 2g. Scale A Web Server

[← Back to index](../index.md)

## 1. An introduction to YAML

https://yaml.org/

## 2. Our first compose file

## 3. Compose resources

docker-compose up
docker-compose down

## 4. Configuring our database

## 5. Using a volume

docker-compose up -d pg
docker-compose down
docker volume ls

## 6. Interacting with containers

docker-compose up -d
docker-compose exec alpine sh
ping composeexample_pg_1
ping pg
exit
docker-compose stop alpine
docker-compose rm alpine
docker-compose up -d

