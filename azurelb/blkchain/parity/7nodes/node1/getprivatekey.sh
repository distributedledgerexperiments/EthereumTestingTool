#!/bin/sh
mkdir privdata

cd privdata

export https_proxy="http://10.214.226.142:3130" 

wget https://github.com/afterether/eacct/archive/master.zip

unzip master.zip

cd eacct-master

./getethpkey ../../datadir/keys/renaultpoa/UTC--2020-07-07T08-04-53Z--56e2ef7d-8c04-b814-ddfb-b8539d9a99b7
