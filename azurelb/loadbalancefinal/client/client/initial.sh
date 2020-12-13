#!/bin/sh

echo Nissan!123 | sudo apt-get update -y

echo Nissan!123 | sudo apt-get install default-jdk -y

cd "$(dirname "$0")"

tar -xvf apache-jmeter-5.3.tar 
