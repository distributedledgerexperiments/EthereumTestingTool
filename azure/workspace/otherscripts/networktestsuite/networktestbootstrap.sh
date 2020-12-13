#!/bin/sh

echo Nissan!123 | sudo apt-get update -y

echo Nissan!123 | sudo apt install build-essential -y
echo Nissan!123 | sudo apt install git -y -q
echo Nissan!123 | sudo apt install -y autotools-dev
echo Nissan!123 | sudo apt install -y automake
echo Nissan!123 | sudo apt install -y autoconf

#Bash - all distros

#From bash command line (assumes Git is installed)
git clone https://github.com/mellanox/sockperf
cd sockperf/
./autogen.sh
./configure --prefix=

#make is slower, may take several minutes
make

#make install is fast
echo Nissan!123 | sudo make install






