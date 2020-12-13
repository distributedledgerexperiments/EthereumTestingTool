#!/bin/sh

echo Nissan!123 | sudo apt-get update -y
echo Nissan!123 | sudo apt install sshpass -y

cd blkchain/besu_poa/3nodes/

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

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.4 "./bootnode/startbootnode.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.5 "tar -xvf node1.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.5 "./node1/startnode.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.6 "tar -xvf node2.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.6 "./node2/startnode.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.7 "tar -xvf node3.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.7 "./node3/startnode.sh"

cd ../../../transfer/backend/node3/besu_poa/calliper_stack

tar -cvf calliper.tar calliper

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no calliper.tar renault@10.0.2.8:/home/renault

rm calliper.tar

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.8 "tar -xvf calliper.tar"

# Monitoring Setup
cd ../../../../monitoring/all_ethstats

echo Nissan!123 | sudo apt-get update -y

echo Nissan!123 | sudo apt install docker-compose -y

echo Nissan!123 | sudo chmod 666 /var/run/docker.sock

/bin/bash startdockermonitoronly.sh

# Bootstrap nodes

cd ../../../

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no bootstrap.sh renault@10.0.2.8:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.8 "./bootstrap.sh"

