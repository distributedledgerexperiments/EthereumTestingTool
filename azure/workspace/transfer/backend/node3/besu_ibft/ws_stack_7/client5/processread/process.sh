#!/bin/sh

rm -rf firstresult.csv

rm -rf primary.csv

python3 primary.py

python3 tertiary.py
