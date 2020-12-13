#!/bin/sh

echo Nissan!123 | sudo apt-get update -y
echo Nissan!123 | sudo apt install sshpass -y 

cd blkchain/besu_ibft

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no besu.tar renault@10.0.2.4:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no besu.tar renault@10.0.2.5:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no besu.tar renault@10.0.2.6:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no besu.tar renault@10.0.2.7:/home/renault


cd 3nodes

tar -cvf boot.tar bootnode
tar -cvf node1.tar node1
tar -cvf node2.tar node2
tar -cvf node3.tar node3

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no boot.tar renault@10.0.2.4:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no node1.tar renault@10.0.2.5:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no node2.tar renault@10.0.2.6:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no node3.tar renault@10.0.2.7:/home/renault

rm boot.tar
rm node1.tar
rm node2.tar
rm node3.tar

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.4 "tar -xvf boot.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.4 "tar -xvf besu.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.4 "mv besu bootnode"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.4 "./bootnode/startnonvalidator.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.5 "tar -xvf node1.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.5 "tar -xvf besu.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.5 "mv besu node1"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.5 "./node1/startvalidator.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.6 "tar -xvf node2.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.6 "tar -xvf besu.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.6 "mv besu node2"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.6 "./node2/startvalidator.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.7 "tar -xvf node3.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.7 "tar -xvf besu.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.7 "mv besu node3"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.7 "./node3/startvalidator.sh"




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

cd ../queueworkers/besu_ibft/ws_stack_3

tar -cvf client.tar client

tar -cvf client1.tar client1

tar -cvf client2.tar client2

tar -cvf client3.tar client3

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.8:/home/renault

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client1.tar renault@10.0.2.8:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.8 "tar -xvf client1.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.8 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.8 "mv client1/dockercompose15.yml client"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.8 "nohup ./client/basestartdocker.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.9:/home/renault

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client2.tar renault@10.0.2.9:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.9 "tar -xvf client2.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.9 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.9 "mv client2/dockercompose15.yml client"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.9 "nohup ./client/basestartdocker.sh 1>stdout.txt 2>stderr.txt &"


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

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.14 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.15:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.15 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.15 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.16:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.16 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.16 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.17:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.17 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.17 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.18:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.18 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.18 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.19:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.19 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.19 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.20:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.20 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.20 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.21:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.21 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.21 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.22:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.22 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.22 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.23:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.23 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.23 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.24:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.24 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.24 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.25:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.25 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.25 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.26:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.26 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.26 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.27:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.27 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.27 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.28:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.28 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.28 "./client/initial.sh"

rm client.tar


