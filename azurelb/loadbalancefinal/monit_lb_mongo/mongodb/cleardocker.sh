#!/bin/sh

docker container stop $(docker container ls -a -q)

docker container rm $(docker container ls -a -q)

docker image rm $(docker image ls -a -q)

docker-compose -f dockercompose.yml down

echo nissan123 | sudo -S rm -rf envoydata

echo nissan123 | sudo -S rm -rf nginxdata

echo nissan123 | sudo -S rm -rf volumedata

echo nissan123 | sudo -S rm -rf mongodbdata1

echo nissan123 | sudo -S rm -rf mongodbdata2

echo nissan123 | sudo -S rm -rf mongodbdata3

echo nissan123 | sudo -S rm -rf mongodbdata4
