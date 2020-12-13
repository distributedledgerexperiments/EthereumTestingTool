#!/bin/sh

cd "$(dirname "$0")"

rm -rf jmeter.log

rm -rf testjmete

rm -rf test.jtl
 
nohup ./apache-jmeter-5.3/bin/jmeter -n -t sample2.jmx -l test.jtl 1>stdout.txt 2>stderr.txt &
