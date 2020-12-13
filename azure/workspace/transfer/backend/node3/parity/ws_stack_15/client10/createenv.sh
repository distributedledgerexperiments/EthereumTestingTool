#!/bin/sh

cd "$(dirname "$0")"

rm -rf poa

#export https_proxy="http://10.214.226.142:3130"

echo Nissan!123 | sudo -S apt-get update

echo Nissan!123 | sudo -S apt-get install python3-venv -y


echo Nissan!123 | sudo -S apt-get install python3 python-dev python3-dev libssl-dev libxml2-dev libxslt1-dev zlib1g-dev python3-pip python-pip -y


echo Nissan!123 | sudo -S apt install build-essential automake pkg-config libtool libffi-dev libgmp-dev libsecp256k1-dev jq -y

wget https://github.com/ethereum/solidity/releases/download/v0.4.24/solc-static-linux

chmod 755 solc-static-linux

echo Nissan!123 | sudo -S mv solc-static-linux /usr/local/bin/

sudo ln -s /usr/local/bin/solc-static-linux /usr/local/bin/solc

python3 -m venv poa

echo Nissan!123| sudo -S apt-get install python3-dev -y

echo Nissan!123| sudo -S apt-get install python-pip -y


poa/bin/pip install wheel web3 pandas websocket_client typing-extensions pymongo py-solc eth-testrpc

poa/bin/pip install --pre eth-utils --no-deps

