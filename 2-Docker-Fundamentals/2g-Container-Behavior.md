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
