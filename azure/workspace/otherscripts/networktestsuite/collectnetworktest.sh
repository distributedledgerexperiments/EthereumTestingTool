#!/bin/sh

# Bootstrap Network Test

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no renault@10.0.2.4:/home/renault/stdout.txt ./server1.txt

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no renault@10.0.2.9:/home/renault/stdout.txt ./client1.txt

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no renault@10.0.2.8:/home/renault/stdout.txt ./server2.txt

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no renault@10.0.2.13:/home/renault/stdout.txt ./client2.txt





