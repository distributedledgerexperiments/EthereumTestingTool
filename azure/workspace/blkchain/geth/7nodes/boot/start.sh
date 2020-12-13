#!/bin/sh

cd "$(dirname "$0")"

#clear the log file

rm -rf nohup.out

rm -rf stdout.txt

rm -rf stderr.txt

nohup ./geth/bootnode --nodekey=boot.key 1>stdout.txt 2>stderr.txt &

