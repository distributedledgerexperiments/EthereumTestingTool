#!/bin/sh

echo Nissan!123 | sudo apt-get update -y
echo Nissan!123 | sudo apt install sshpass -y

# Bootstrap Network Test

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no networktestbootstrap.sh renault@10.0.2.4:/home/renault

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no networktestbootstrap.sh renault@10.0.2.9:/home/renault

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no networktestbootstrap.sh renault@10.0.2.8:/home/renault

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no networktestbootstrap.sh renault@10.0.2.13:/home/renault


sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.4 "./networktestbootstrap.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.9 "./networktestbootstrap.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.8 "./networktestbootstrap.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.13 "./networktestbootstrap.sh"


# Start Network Test between 10.0.2.4 & 10.0.2.9 as well as for 10.0.2.8 & 10.0.2.13

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no networktestserver.sh renault@10.0.2.4:/home/renault

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no networktestclient.sh renault@10.0.2.9:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.4 "./networktestserver.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.9 "./networktestclient.sh"


#####


sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no networktestserver1.sh renault@10.0.2.8:/home/renault

sshpass -p Nissan!123 scp -o StrictHostKeyChecking=no networktestclient1.sh renault@10.0.2.13:/home/renault

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.8 "./networktestserver1.sh"

sshpass -p Nissan!123 ssh -o StrictHostKeyChecking=no renault@10.0.2.13 "./networktestclient1.sh"

