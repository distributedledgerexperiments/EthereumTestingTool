#!/bin/sh

 docker cp $(docker container ls -f "name=worker1" -q):/home/renault/10.214.226.361.csv .
