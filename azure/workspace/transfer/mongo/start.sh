#!/bin/sh

cd "$(dirname "$0")"

docker container stop $(docker container ls -aq)

docker container rm $(docker container ls -aq)

docker run -d -p 27017:27017 --name mongodb -e MONGO_INITDB_ROOT_USERNAME=guest -e MONGO_INITDB_ROOT_PASSWORD=guest mongo

docker ps

