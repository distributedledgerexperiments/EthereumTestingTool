#!/bin/sh

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.8 "nohup ./client1/thirditeration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.9 "nohup ./client2/thirditeration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.10 "nohup ./client3/thirditeration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.18 "nohup ./client4/thirditeration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.19 "nohup ./client5/thirditeration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.20 "nohup ./client6/thirditeration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.21 "nohup ./client7/thirditeration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.26 "nohup ./client8/thirditeration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.27 "nohup ./client9/thirditeration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.28 "nohup ./client10/thirditeration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.29 "nohup ./client11/thirditeration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.34 "nohup ./client12/thirditeration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.35 "nohup ./client13/thirditeration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.36 "nohup ./client14/thirditeration_client.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.37 "nohup ./client15/thirditeration_client.sh 1>stdout.txt 2>stderr.txt &"
