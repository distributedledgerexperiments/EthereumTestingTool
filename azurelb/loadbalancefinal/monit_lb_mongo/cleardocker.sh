#!/bin/sh

docker container stop $(docker container ls -a -q)

docker container rm $(docker container ls -a -q)

docker image rm $(docker image ls -a -q)

docker-compose -f dockercompose.yml down

echo nissan123 | sudo -S rm -rf envoydata

echo nissan123 | sudo -S rm -rf nginxdata

echo nissan123 | sudo -S rm -rf nginxdata2

echo nissan123 | sudo -S rm -rf nginxdata3

echo nissan123 | sudo -S rm -rf nginxdata4

echo nissan123 | sudo -S rm -rf nginxdata5

echo nissan123 | sudo -S rm -rf nginxdata6

echo nissan123 | sudo -S rm -rf volumedata

echo nissan123 | sudo -S rm -rf mongodbdata1

echo nissan123 | sudo -S rm -rf mongodbdata2

echo nissan123 | sudo -S rm -rf mongodbdata3

echo nissan123 | sudo -S rm -rf mongodbdata4

echo nissan123 | sudo -S rm -rf mongodbdata5

echo nissan123 | sudo -S rm -rf mongodbdata6

echo nissan123 | sudo -S rm -rf mongodbdata7

echo nissan123 | sudo -S rm -rf mongodbdata8

echo nissan123 | sudo -S rm -rf mongodbdata9

echo nissan123 | sudo -S rm -rf mongodbdata10

echo nissan123 | sudo -S rm -rf mongodbdata11

echo nissan123 | sudo -S rm -rf mongodbdata12
