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

## 7. Assignment: Intergating our webapp in the docker-compose

* Create the `app.env` file
  * With the environment variables to configure the `jfahrer/demo_web_app`
* Add a new service definition `webapp` to the compose file
  * Use `jfahrer/demo_web_app:latest`
  * Use the app.env file
  * Publish port 9292
* Start the services using docker-compose
  * Start the database first
  * The web app second
* Use your browser to verify it works
  * http://localhost:4567

## 8. Managing environment variables
