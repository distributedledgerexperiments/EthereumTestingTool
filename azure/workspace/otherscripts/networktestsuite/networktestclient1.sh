#!/bin/sh


echo Nissan!123 | nohup sockperf ping-pong -i 10.0.2.8 --tcp -m 350 -t 101 -p 12345  --full-rtt 1>stdout.txt 2>stderr.txt &



