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


cd 7nodes

tar -cvf boot.tar bootnode
tar -cvf node1.tar node1
tar -cvf node2.tar node2
tar -cvf node3.tar node3
tar -cvf node4.tar node4
tar -cvf node5.tar node5
tar -cvf node6.tar node6
tar -cvf node7.tar node7

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no boot.tar renault@10.0.2.4:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no node1.tar renault@10.0.2.5:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no node2.tar renault@10.0.2.6:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no node3.tar renault@10.0.2.7:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no node4.tar renault@10.0.2.14:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no node5.tar renault@10.0.2.15:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no node6.tar renault@10.0.2.16:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no node7.tar renault@10.0.2.17:/home/renault

rm boot.tar
rm node1.tar
rm node2.tar
rm node3.tar
rm node4.tar
rm node5.tar
rm node6.tar
rm node7.tar

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


cd ../../../transfer/backend/node3/besu_poa/ws_stack_7

tar -cvf client1.tar client1
tar -cvf client2.tar client2
tar -cvf client3.tar client3
tar -cvf client4.tar client4
tar -cvf client5.tar client5
tar -cvf client6.tar client6
tar -cvf client7.tar client7

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client1.tar renault@10.0.2.8:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client2.tar renault@10.0.2.9:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client3.tar renault@10.0.2.10:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client4.tar renault@10.0.2.18:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client5.tar renault@10.0.2.19:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client6.tar renault@10.0.2.20:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client7.tar renault@10.0.2.21:/home/renault

rm client1.tar
rm client2.tar
rm client3.tar
rm client4.tar
rm client5.tar
rm client6.tar
rm client7.tar

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.8 "tar -xvf client1.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.9 "tar -xvf client2.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.10 "tar -xvf client3.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.18 "tar -xvf client4.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.19 "tar -xvf client5.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.20 "tar -xvf client6.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.21 "tar -xvf client7.tar"


# Monitoring Setup
cd ../../../../monitoring/7nodes/all_ethstats

echo Nissan!123 | sudo apt-get update -y

echo Nissan!123 | sudo apt install docker-compose -y

echo Nissan!123 | sudo chmod 666 /var/run/docker.sock

/bin/bash startdockermonitoronly.sh

# Bootstrap nodes

cd ../../../../

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no bootstrap.sh renault@10.0.2.11:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.11 "./bootstrap.sh"

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no bootstrap.sh renault@10.0.2.12:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.12 "./bootstrap.sh"

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no bootstrap.sh renault@10.0.2.13:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.13 "./bootstrap.sh"

#Mongo setup

cd transfer/mongo

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no start.sh renault@10.0.2.11:/home/renault

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no stop.sh renault@10.0.2.11:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.11 "./start.sh"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no start.sh renault@10.0.2.12:/home/renault

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no stop.sh renault@10.0.2.12:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.12 "./start.sh"


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no start.sh renault@10.0.2.13:/home/renault

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no stop.sh renault@10.0.2.13:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.13 "./start.sh"

