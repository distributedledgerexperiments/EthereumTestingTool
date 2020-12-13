#!/bin/sh

cd "$(dirname "$0")"

docker container stop $(docker container ls -a -q)

docker container rm $(docker container ls -a -q)

docker image rm $(docker image ls -a -q)

