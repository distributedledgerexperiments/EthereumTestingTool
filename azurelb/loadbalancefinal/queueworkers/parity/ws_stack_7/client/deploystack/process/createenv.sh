#!/bin/sh

rm -rf poa

python3 -m venv poa

source poa/bin/activate

#echo nissan| sudo -S apt-get install python3-dev

export https_proxy="http://10.214.226.142:3130"

poa/bin/pip install wheel web3 pandas websocket_client typing-extensions pymongo
