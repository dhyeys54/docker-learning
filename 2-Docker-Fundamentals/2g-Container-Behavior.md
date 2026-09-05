# 2g. Container Behavior

[← Back to index](../index.md)

### 1. The environment

Each container has its own environment variables, seeded from the image (`ENV` instructions) and any `-e` flags passed at `run` time — changes made inside a running container (like `export`) don't persist beyond that container's life.

```
docker container run jfahrer/myalpine:latest
export PS1='test '
export PS1="\h:\w# "
exit
docker container run -it -e "PS1=\h:\w# " jfahrer/myalpine:latest
```

### 2. The ENV instruction

The Dockerfile `ENV` instruction sets a default environment variable baked into the image. `-e` at `run` time overrides it for that container only.

```
docker container run jfahrer/myalpine:latest env
docker container run -e "PS2=> " jfahrer/myalpine:latest env
```

### 3. More on env vars

`--env-file` loads a whole file of `KEY=VALUE` pairs at once. `-e VARNAME` (no `=value`) passes through a variable already set in the host shell, without needing to repeat its value.

```
app.env
echo MYVAR=test >> app.env
echo FOO=bar >> app.env

export OTHERVAR=local-test
docker container run --env-file app.env -e OTHERVAR alpine:latest env

echo OTHERVAR >> app.env
docker container run --env-file app.env alpine:latest env
```

### 4. Postgres in a nutshell

`psql` is Postgres's interactive CLI client, used to connect to and query a running Postgres server:

```
psql -h localhost -U julian test
```

### 5. Configuring postgres

The official `postgres` image is configured entirely through environment variables at first startup — e.g. `POSTGRES_USER`/`POSTGRES_PASSWORD` create the initial superuser/credentials.

```
docker container run --rm --name pg -d -e "POSTGRES_USER=myuser" -e "POSTGRES_PASSWORD=secret" postgres:9.6.6-alpine
docker container run --rm --link pg -it postgres:9.6.6-alpine psql -h pg -U myuser
```

### 6. Using the database

An app container can be pointed at a database container via `--link` and its own `--env-file` holding connection details (host, user, password), keeping config out of the image itself.

```
docker container run -d --name pg --env-file db.env postgres:9.6.6-alpine
docker container run -d --link pg --env-file app.env -p 9292:9292 jfahrer/demo_web_app
```

### Assignment 1

* Try it yourself
* Use a user defined network instead of links
* Use the same env file for both containers
* Set the env vars locally and use the -e flag
  * `"-e POSTGRES_DB" -e "POSTGRES_USER" …` syntax

```
docker network create ruby-pg

docker container run --rm --name pq --network ruby-pg --env-file "env-files/db-test2.env" -d postgres:alpine

# ruby server image

docker image build -f tasks/webserver-ruby/Dockerfile -t ruby-webserver:latest .

docker container run --rm --name ruby-server --network ruby-pg --env-file "env-files/app-test3.env" -d -p 4567:4567 ruby-webserver:latest
```

### Assignment 2

* Start multiple instances of your previous server
* They should all connect to the same database
* Use different port mappings

```
docker network create ruby-pg

docker container run --rm --name pg --network ruby-pg --env-file "env-files/app-test3.env" -d postgres:alpine

# ruby server image

docker image build -f tasks/webserver-ruby/Dockerfile -t ruby-webserver:latest .

docker container run --rm --name ruby-server --network ruby-pg --env-file "env-files/app-test3.env" -d -p 4567:4567 ruby-webserver:latest

docker container run --rm --name ruby-server1 --network ruby-pg --env-file "env-files/app-test3.env" -d -p 4568:4567 ruby-webserver:latest
```