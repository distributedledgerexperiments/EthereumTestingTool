#!/bin/sh

cd "$(dirname "$0")"

rm -rf stdout.txt

rm -rf stderr.txt

rm -rf nohup.out



nohup ./parity/openethereum --config node.toml 1>stdout.txt 2>stderr.txt &
