#!/bin/sh

cd process

rm -rf firstresult.csv

rm -rf primary.csv

../poa/bin/python3 primary.py

../poa/bin/python3 tertiary.py
