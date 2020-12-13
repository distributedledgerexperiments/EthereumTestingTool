#!/bin/sh

#-p machineport:containerport

#docker run -d -p 5672:5672 -p 15672:15672 rabbitmq:3.6-management-alpine

#docker run -d -p 6379:6379 redis:6.0.3-alpine

#docker run --name docker-nginx -p 8080:80 -v /home/renault/Documents/ethereumpoa/loadbalancemodule_bak/default.conf:/etc/nginx/conf.d/default.conf -v /home/renault/Documents/ethereumpoa/loadbalancemodule_bak/nginx.conf:/etc/nginx/nginx.conf -d nginx 

#docker run --name docker-envoy -p 8080:8080 -p 8081:8081 -v /home/renault/Documents/ethereumpoa/loadbalancemodule_bak/envoy.yaml:/etc/envoy/envoy.yaml -d envoyproxy/envoy-alpine:v1.14.1

docker-compose -f dockercompose.yml up -d
