#!/bin/sh

cd "$(dirname "$0")"

cd processread

rm -rf firstresult.csv


../poa/bin/python3 primary.py
