#!/bin/sh

#clear the log file

pgrep -f geth | xargs kill -9

cd "$(dirname "$0")"

rm -rf nohup.out

rm -rf stdout.txt

rm -rf stderr.txt

rm -rf datadir

mkdir datadir

./geth/geth --datadir=datadir account import --password password.txt privkeyfile.txt

./geth/geth --datadir=datadir init renaultpoa.json

nohup ./geth/geth --nousb --networkid "26" --datadir=datadir --rpc --rpcapi web3,eth,clique,personal,miner,net,txpool,admin,debug,miner --ws --wsaddr "0.0.0.0" --wsapi web3,eth,clique,personal,miner,net,txpool,admin,debug,miner --wsport "2200" --wsorigins "*" --rpcport "2000"  --bootnodes "enode://4f4ac4489c58d90fe148ab9bda275b376f34ce2ec043904cadb47b7f0060a048c9da0e77883e6b82f77cdf47f01b845439732ff12094c622bbe80a16bc3af7ed@10.0.2.4:0?discport=30301" --rpccorsdomain "*" --rpcaddr "0.0.0.0" --unlock "0x69c93cCc6Be4D66bd8c9C50bf1546e52a83B8053" --allow-insecure-unlock --password "password.txt" --mine --miner.threads "7" --etherbase "0x69c93cCc6Be4D66bd8c9C50bf1546e52a83B8053" --miner.gasprice "1" --txpool.globalslots "1000000" --txpool.accountqueue "1000000" --syncmode "full" --miner.gastarget "228894000" --miner.gaslimit "228894000" --metrics --cache "1024" --metrics.expensive --pprof --pprofaddr="0.0.0.0" --graphql --graphql.vhosts "*" --graphql.corsdomain "*" --graphql.addr "0.0.0.0" 1>stdout.txt 2>stderr.txt &
