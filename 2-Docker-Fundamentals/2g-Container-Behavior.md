# 2e. Data in images

[← Back to index](../index.md)

### 1. The environment

docker container run jfahrer/myalpine:latest
export PS1='test '
export PS1="\h:\w# "
exit
docker container run -it -e "PS1=\h:\w# " jfahrer/myalpine:latest

### 2. The ENV instruction

docker container run jfahrer/myalpine:latest env
docker container run -e "PS2=> " jfahrer/myalpine:latest env

### 3. More on env vars

app.env
echo MYVAR=test >> app.env
echo FOO=bar >> app.env

export OTHERVAR=local-test
docker container run --env-file app.env -e OTHERVAR alpine:latest env

echo OTHERVAR >> app.env
docker container run --env-file app.env alpine:latest env