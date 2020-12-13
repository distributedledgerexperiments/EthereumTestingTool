#!/bin/sh

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.8 "nohup ./client1/seconditeration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.9 "nohup ./client2/seconditeration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.10 "nohup ./client3/seconditeration_client.sh 1>stdout.txt 2>stderr.txt &"
