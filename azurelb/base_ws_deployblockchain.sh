#!/bin/sh

echo Nissan!123 | sudo apt-get update -y
echo Nissan!123 | sudo apt install sshpass -y 





#Mongo DB
cd ../../../loadbalancefinal/

tar -cvf mongodb.tar mongodb

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no mongodb.tar renault@10.0.2.11:/home/renault

rm mongodb.tar

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.11 "tar -xvf mongodb.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.11 "./mongodb/startdocker.sh"


# Monitoring Setup
cd monitoring/3nodes/all_ethstats

echo Nissan!123 | sudo apt-get update -y

echo Nissan!123 | sudo apt install docker-compose -y

echo Nissan!123 | sudo chmod 666 /var/run/docker.sock

/bin/bash startdockermonitoronly.sh

# Loadbalancing set

cd ../../../lnginxbalancer/

tar -cvf 3nodes.tar 3nodes

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no 3nodes.tar renault@10.0.2.12:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.12 "tar -xvf 3nodes.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.12 "./3nodes/startdocker.sh"

rm 3nodes.tar

# AIO server set

cd ../queueworkers/geth/ws_stack_3

tar -cvf client.tar client

tar -cvf client1.tar client1

tar -cvf client2.tar client2

tar -cvf client3.tar client3

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.8:/home/renault

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client1.tar renault@10.0.2.8:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.8 "tar -xvf client1.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.8 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.8 "mv client1/dockercompose15.yml client"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.8 "./client/basestartdocker.sh"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.9:/home/renault

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client2.tar renault@10.0.2.9:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.9 "tar -xvf client2.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.9 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.9 "mv client2/dockercompose15.yml client"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.9 "./client/basestartdocker.sh"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.10:/home/renault

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client3.tar renault@10.0.2.10:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.10 "tar -xvf client3.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.10 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.10 "mv client3/dockercompose15.yml client"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.10 "./client/basestartdocker.sh"

rm client.tar

rm client1.tar

rm client2.tar

rm client3.tar

# Client config

cd ../../../client

tar -cvf client.tar client

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.14:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.14 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.14 "./client/initial.sh"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.15:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.15 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.15 "./client/initial.sh"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.16:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.16 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.16 "./client/initial.sh"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.17:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.17 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.17 "./client/initial.sh"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.18:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.18 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.18 "./client/initial.sh"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.19:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.19 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.19 "./client/initial.sh"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.20:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.20 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.20 "./client/initial.sh"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.21:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.21 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.21 "./client/initial.sh"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.22:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.22 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.22 "./client/initial.sh"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.23:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.23 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.23 "./client/initial.sh"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.24:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.24 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.24 "./client/initial.sh"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.25:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.25 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.25 "./client/initial.sh"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.26:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.26 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.26 "./client/initial.sh"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.27:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.27 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.27 "./client/initial.sh"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.28:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.28 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.28 "./client/initial.sh"








