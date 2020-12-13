#!/bin/sh


echo Nissan!123 | nohup sudo sockperf sr --tcp -i 10.0.2.8 -p 12345 1>stdout.txt 2>stderr.txt &



