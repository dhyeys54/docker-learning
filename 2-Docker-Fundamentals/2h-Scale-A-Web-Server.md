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

