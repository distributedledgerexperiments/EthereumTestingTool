#!/bin/sh
echo Nissan!123 | sudo apt-get update -y

echo Nissan!123 | sudo apt-get install default-jdk -y


cd "$(dirname "$0")"

cd datadir

rm -rf database

rm -rf caches

cd ..

rm -rf stdout.txt

rm -rf stderr.txt

rm -rf nohup.out

nohup ./besu/bin/besu --data-path=datadir --genesis-file=genesis.json --bootnodes="enode://16c1d42684d1343a08b387f2e64a039af661790abe0ff59d0048a521a42e1372c75242056c17971e80f3774cf007f8e74691f6d09439ae98d5942d7ed0b529c4@10.0.2.4:30303" --network-id 26 --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT,WEB3,ADMIN,TXPOOL --host-whitelist="*" --rpc-http-cors-origins="all" --rpc-http-port=2000 --rpc-http-host="0.0.0.0" --rpc-ws-enabled --rpc-ws-host="0.0.0.0" --rpc-ws-port=2200 --rpc-ws-api=ETH,NET,CLIQUE,WEB3,ADMIN,TXPOOL --min-gas-price=1 --target-gas-limit=228894000 --tx-pool-max-size=80000000 --tx-pool-hashes-max-size=80000000 1>stdout.txt 2>stderr.txt &
