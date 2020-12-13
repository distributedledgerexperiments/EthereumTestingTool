#!/bin/sh

echo Nissan!123 | sudo apt-get update -y
echo Nissan!123 | sudo apt install sshpass -y

cd blkchain/besu_poa

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no besu.tar renault@10.0.2.4:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no besu.tar renault@10.0.2.5:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no besu.tar renault@10.0.2.6:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no besu.tar renault@10.0.2.7:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no besu.tar renault@10.0.2.14:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no besu.tar renault@10.0.2.15:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no besu.tar renault@10.0.2.16:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no besu.tar renault@10.0.2.17:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no besu.tar renault@10.0.2.22:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no besu.tar renault@10.0.2.23:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no besu.tar renault@10.0.2.24:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no besu.tar renault@10.0.2.25:/home/renault


cd 11nodes

tar -cvf boot.tar bootnode
tar -cvf node1.tar node1
tar -cvf node2.tar node2
tar -cvf node3.tar node3
tar -cvf node4.tar node4
tar -cvf node5.tar node5
tar -cvf node6.tar node6
tar -cvf node7.tar node7
tar -cvf node8.tar node8
tar -cvf node9.tar node9
tar -cvf node10.tar node10
tar -cvf node11.tar node11


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no boot.tar renault@10.0.2.4:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no node1.tar renault@10.0.2.5:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no node2.tar renault@10.0.2.6:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no node3.tar renault@10.0.2.7:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no node4.tar renault@10.0.2.14:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no node5.tar renault@10.0.2.15:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no node6.tar renault@10.0.2.16:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no node7.tar renault@10.0.2.17:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no node8.tar renault@10.0.2.22:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no node9.tar renault@10.0.2.23:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no node10.tar renault@10.0.2.24:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no node11.tar renault@10.0.2.25:/home/renault

rm boot.tar
rm node1.tar
rm node2.tar
rm node3.tar
rm node4.tar
rm node5.tar
rm node6.tar
rm node7.tar
rm node8.tar
rm node9.tar
rm node10.tar
rm node11.tar

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.4 "tar -xvf boot.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.4 "tar -xvf besu.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.4 "mv besu bootnode"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.4 "./bootnode/startbootnode.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.5 "tar -xvf node1.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.5 "tar -xvf besu.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.5 "mv besu node1"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.5 "./node1/startnode.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.6 "tar -xvf node2.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.6 "tar -xvf besu.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.6 "mv besu node2"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.6 "./node2/startnode.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.7 "tar -xvf node3.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.7 "tar -xvf besu.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.7 "mv besu node3"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.7 "./node3/startnode.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.14 "tar -xvf node4.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.14 "tar -xvf besu.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.14 "mv besu node4"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.14 "./node4/startnode.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.15 "tar -xvf node5.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.15 "tar -xvf besu.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.15 "mv besu node5"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.15 "./node5/startnode.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.16 "tar -xvf node6.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.16 "tar -xvf besu.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.16 "mv besu node6"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.16 "./node6/startnode.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.17 "tar -xvf node7.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.17 "tar -xvf besu.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.17 "mv besu node7"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.17 "./node7/startnode.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.22 "tar -xvf node8.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.22 "tar -xvf besu.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.22 "mv besu node8"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.22 "./node8/startnode.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.23 "tar -xvf node9.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.23 "tar -xvf besu.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.23 "mv besu node9"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.23 "./node9/startnode.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.24 "tar -xvf node10.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.24 "tar -xvf besu.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.24 "mv besu node10"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.24 "./node10/startnode.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.25 "tar -xvf node11.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.25 "tar -xvf besu.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.25 "mv besu node11"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.25 "./node11/startnode.sh"



#Mongo DB
cd ../../../loadbalancefinal/

tar -cvf mongodb.tar mongodb

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no mongodb.tar renault@10.0.2.11:/home/renault

rm mongodb.tar

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.11 "tar -xvf mongodb.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.11 "./mongodb/startdocker.sh"


# Monitoring Setup
cd monitoring/11nodes/all_ethstats

echo Nissan!123 | sudo apt-get update -y

echo Nissan!123 | sudo apt install docker-compose -y

echo Nissan!123 | sudo chmod 666 /var/run/docker.sock

/bin/bash startdockermonitoronly.sh

# Loadbalancing set

cd ../../../lnginxbalancer/

tar -cvf 11nodes.tar 11nodes

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no 11nodes.tar renault@10.0.2.12:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.12 "tar -xvf 11nodes.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.12 "./11nodes/startdocker.sh"

rm 11nodes.tar

# AIO server set

cd ../queueworkers/besu_poa/ws_stack_11

tar -cvf client.tar client

tar -cvf client1.tar client1

tar -cvf client2.tar client2

tar -cvf client3.tar client3

tar -cvf client4.tar client4

tar -cvf client5.tar client5

tar -cvf client6.tar client6

tar -cvf client7.tar client7

tar -cvf client8.tar client8

tar -cvf client9.tar client9

tar -cvf client10.tar client10

tar -cvf client11.tar client11




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

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.10 "nohup ./client/basestartdocker.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.18:/home/renault

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client4.tar renault@10.0.2.18:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.18 "tar -xvf client4.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.18 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.18 "mv client4/dockercompose15.yml client"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.18 "nohup ./client/basestartdocker.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.19:/home/renault

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client5.tar renault@10.0.2.19:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.19 "tar -xvf client5.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.19 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.19 "mv client5/dockercompose15.yml client"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.19 "nohup ./client/basestartdocker.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.20:/home/renault

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client6.tar renault@10.0.2.20:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.20 "tar -xvf client6.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.20 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.20 "mv client6/dockercompose15.yml client"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.20 "nohup ./client/basestartdocker.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.21:/home/renault

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client7.tar renault@10.0.2.21:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.21 "tar -xvf client7.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.21 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.21 "mv client7/dockercompose15.yml client"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.21 "nohup ./client/basestartdocker.sh 1>stdout.txt 2>stderr.txt &"



sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.26:/home/renault

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client8.tar renault@10.0.2.26:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.26 "tar -xvf client8.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.26 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.26 "mv client8/dockercompose15.yml client"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.26 "nohup ./client/basestartdocker.sh 1>stdout.txt 2>stderr.txt &"



sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.27:/home/renault

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client9.tar renault@10.0.2.27:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.27 "tar -xvf client9.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.27 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.27 "mv client9/dockercompose15.yml client"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.27 "nohup ./client/basestartdocker.sh 1>stdout.txt 2>stderr.txt &"



sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.28:/home/renault

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client10.tar renault@10.0.2.28:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.28 "tar -xvf client10.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.28 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.28 "mv client10/dockercompose15.yml client"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.28 "nohup ./client/basestartdocker.sh 1>stdout.txt 2>stderr.txt &"



sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.29:/home/renault

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client11.tar renault@10.0.2.29:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.29 "tar -xvf client11.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.29 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.29 "mv client11/dockercompose15.yml client"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.29 "./client/basestartdocker.sh"





rm client.tar

rm client1.tar

rm client2.tar

rm client3.tar

rm client4.tar

rm client5.tar

rm client6.tar

rm client7.tar

rm client8.tar

rm client9.tar

rm client10.tar

rm client11.tar


# Client config Jmeter

cd ../../../client

tar -cvf client.tar client

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.30:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.30 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.30 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.31:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.31 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.31 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.32:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.32 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.32 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.33:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.33 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.33 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.34:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.34 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.34 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.35:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.35 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.35 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.36:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.36 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.36 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.37:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.37 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.37 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.38:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.38 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.38 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.39:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.39 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.39 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.40:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.40 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.40 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.41:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.41 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.41 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.42:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.42 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.42 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.43:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.43 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.43 "nohup ./client/initial.sh 1>stdout.txt 2>stderr.txt &"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client.tar renault@10.0.2.44:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.44 "tar -xvf client.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.44 "./client/initial.sh"

rm client.tar
