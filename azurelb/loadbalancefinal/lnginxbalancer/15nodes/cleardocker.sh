#!/bin/sh
cd "$(dirname "$0")"

docker container stop $(docker container ls -a -q)

docker container rm $(docker container ls -a -q)

docker image rm $(docker image ls -a -q)

docker-compose -f dockercompose.yml down

echo Nissan!123 | sudo -S rm -rf envoydata

echo Nissan!123 | sudo -S rm -rf envoydata2

echo Nissan!123 | sudo -S rm -rf nginxdata2

echo Nissan!123 | sudo -S rm -rf nginxdata

echo Nissan!123 | sudo -S rm -rf volumedata

echo Nissan!123 | sudo -S rm -rf mongodbdata
