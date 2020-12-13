#!/bin/sh
#mkdir privdata

#cd privdata

#export https_proxy="http://10.214.226.142:3130" 

#wget https://github.com/afterether/eacct/archive/master.zip

#unzip master.zip

#cd eacct-master

./parity/openethereum account new --config node.toml

./privdata/eacct-master/getethpkey datadir/keys/renaultpoa/*
