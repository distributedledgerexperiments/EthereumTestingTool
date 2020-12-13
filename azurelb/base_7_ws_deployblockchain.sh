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
cd monitoring/7nodes/all_ethstats

echo Nissan!123 | sudo apt-get update -y

echo Nissan!123 | sudo apt install docker-compose -y

echo Nissan!123 | sudo chmod 666 /var/run/docker.sock

/bin/bash startdockermonitoronly.sh

# Loadbalancing set

cd ../../../lnginxbalancer/

tar -cvf 7nodes.tar 7nodes

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no 7nodes.tar renault@10.0.2.12:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.12 "tar -xvf 7nodes.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.12 "./7nodes/startdocker.sh"

rm 7nodes.tar

# AIO server set

cd ../queueworkers/geth/ws_stack_7

tar -cvf client.tar client

tar -cvf client1.tar client1

tar -cvf client2.tar client2

tar -cvf client3.tar client3

tar -cvf client4.tar client4

tar -cvf client5.tar client5

tar -cvf client6.tar client6

tar -cvf client7.tar client7




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


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.18:/home/renault

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client4.tar renault@10.0.2.18:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.18 "tar -xvf client4.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.18 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.18 "mv client4/dockercompose15.yml client"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.18 "./client/basestartdocker.sh"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.19:/home/renault

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client5.tar renault@10.0.2.19:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.19 "tar -xvf client5.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.19 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.19 "mv client5/dockercompose15.yml client"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.19 "./client/basestartdocker.sh"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.20:/home/renault

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client6.tar renault@10.0.2.20:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.20 "tar -xvf client6.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.20 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.20 "mv client6/dockercompose15.yml client"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.20 "./client/basestartdocker.sh"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.21:/home/renault

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client7.tar renault@10.0.2.21:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.21 "tar -xvf client7.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.21 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.21 "mv client7/dockercompose15.yml client"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.21 "./client/basestartdocker.sh"





rm client.tar

rm client1.tar

rm client2.tar

rm client3.tar

rm client4.tar

rm client5.tar

rm client6.tar

rm client7.tar

# Client config Jmeter

cd ../../../client

tar -cvf client.tar client

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


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.29:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.29 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.29 "./client/initial.sh"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.30:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.30 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.30 "./client/initial.sh"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.31:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.31 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.31 "./client/initial.sh"



