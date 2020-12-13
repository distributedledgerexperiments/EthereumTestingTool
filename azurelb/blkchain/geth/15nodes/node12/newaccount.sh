#!/bin/sh

#new account

./geth/geth --datadir=datadir account new --password password.txt

# get private key

# To install web3

# curl -LSs https://raw.githubusercontent.com/gochain/web3/master/install.sh | sh

web3 account extract --keyfile datadir/keystore/* --password nissan

