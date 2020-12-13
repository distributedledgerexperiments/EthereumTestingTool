#!/bin/sh

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.8 "nohup ./client1/createenv.sh 1>stdout.txt 2>stderr.txt &"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.9 "./client2/createenv.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.10 "./client3/createenv.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.8 "./client1/deploycontract.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.8 "./client1/checkstatus.sh"
