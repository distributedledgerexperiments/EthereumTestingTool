#!/bin/sh

docker-compose -f dockercomposemonitor.yml down

docker container stop $(docker container ls -aq)

docker container rm $(docker container ls -aq)
