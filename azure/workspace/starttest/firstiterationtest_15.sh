#!/bin/sh

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.8 "nohup ./client1/firstiteration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.9 "nohup ./client2/firstiteration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.10 "nohup ./client3/firstiteration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.18 "nohup ./client4/firstiteration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.19 "nohup ./client5/firstiteration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.20 "nohup ./client6/firstiteration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.21 "nohup ./client7/firstiteration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.26 "nohup ./client8/firstiteration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.27 "nohup ./client9/firstiteration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.28 "nohup ./client10/firstiteration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.29 "nohup ./client11/firstiteration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.34 "nohup ./client12/firstiteration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.35 "nohup ./client13/firstiteration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.36 "nohup ./client14/firstiteration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.37 "nohup ./client15/firstiteration_client.sh 1>stdout.txt 2>stderr.txt &"
