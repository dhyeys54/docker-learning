# 2g. Scale A Web Server

[← Back to index](../index.md)

## 1. What we will build

Here we are building load balancer using nginx as a reverse proxy.

## 2. Making it dynamic

Making env variables dynamic

## 3. Running the loadbalancer

## 4. It does not stop

The nginx is called from the script and diesn't become process with pid 1, so it doesn't recieve the sigterm event
run using exec

## 5. Assignment: Use the load balancer
* Setup an user defined network
  * Connect all containers to this network
* Setup a postgres database
  * Setup a user with a password and a database
* Start the demo_web_app image
  * Name the container `webapp`
  * Setup the connection to postgres via the environment variables
  * Do not forward any ports
* Start our load balancer
  * Set the environment variable PROXY_UPSTREAM to `webapp:9292`
  * Forward port 80 to the containers port 80
* Open a browser and browse `localhost`


docker network create lb-webapp

docker container run --network lb-webapp --name pg --env-file env-files/lb-task-db.env -v pgdata:/var/lib/postgresql/data --rm -d postgres:alpine

docker image build -f tasks/webserver-ruby/Dockerfile -t fangy54/webserver-ruby:latest .

docker container run --network lb-webapp --name web01 --env-file env-files/lb-task-app.env --rm -dit -p 3000:4567 fangy54/webserver-ruby:latest

docker container run --network lb-webapp --name web02 --env-file env-files/lb-task-app.env --rm -dit -p 3000:4567 fangy54/webserver-ruby:latest

docker image build -f tasks/nginx-loadbalancer/Dockerfile -t fangy54/lb:latest tasks/nginx-loadbalancer

docker container run --network lb-webapp --name lb --rm -it -p 80:80 fangy54/lb:latest

## Assignment scaling a application

docker container run --network lb-webapp --network-alias web-server --env-file env-files/lb-task-app.env --rm -d fangy54/webserver-ruby:latest

docker container run --network lb-webapp --network-alias web-server --env-file env-files/lb-task-app.env --rm -d fangy54/webserver-ruby:latest

docker container run --network lb-webapp -e PROXY_UPSTREAM=web-server:4567 --name lb --rm -it -p 80:80 fangy54/lb:latest