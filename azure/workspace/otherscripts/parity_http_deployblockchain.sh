#!/bin/sh

echo Nissan!123 | sudo apt-get update -y
echo Nissan!123 | sudo apt install sshpass -y

cd blkchain/parity/3nodes/

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

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.4 "./bootnode/startparity.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.5 "tar -xvf node1.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.5 "./node1/startparity.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.6 "tar -xvf node2.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.6 "./node2/startparity.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.7 "tar -xvf node3.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.7 "./node3/startparity.sh"

cd ../../../transfer/backend/node3/parity/http_stack

tar -cvf client1.tar client1
tar -cvf client2.tar client2
tar -cvf client3.tar client3

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client1.tar renault@10.0.2.8:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client2.tar renault@10.0.2.9:/home/renault
sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no client3.tar renault@10.0.2.10:/home/renault

rm client1.tar
rm client2.tar
rm client3.tar

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.8 "tar -xvf client1.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.9 "tar -xvf client2.tar"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.10 "tar -xvf client3.tar"

# Monitoring Setup
cd ../../../../monitoring/all_ethstats

echo Nissan!123 | sudo apt-get update -y

echo Nissan!123 | sudo apt install docker-compose -y

echo Nissan!123 | sudo chmod 666 /var/run/docker.sock

/bin/bash startdockermonitoronly.sh

# Bootstrap nodes

cd ../../../

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

