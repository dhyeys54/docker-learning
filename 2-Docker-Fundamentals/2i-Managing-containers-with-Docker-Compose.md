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

## 9. Specifying dependencies

## 10. Limitations of depends_on

condition: service_started

## 11. Integrate the load balancer

* Add the required environment variable to the .env file
  * Set PROXY_UPSTREAM to `webapp:9292`
* Remove the `web` service definition
* Add a new service definition
  * Call it `lb`
  * Use your load balancer image
    * Or use jfahrer/lb:v2
  * Depend on the service `webapp`
  * Make sure to assign the PROXY_UPSTREAM environment variable
  * Publish port 80
* Stop publishing the `webapp` service
* Start the services using docker-compose
* Use your browser to verify it works
  * http://localhost

## 12. Enhancing the load balancer

## 13. Building the load balancer

docker-compose build
docker-compose build lb
docker-compose up --build

## 14. Scaling a service

docker-compose up -d
docker-compose up -d --scale webapp=5
