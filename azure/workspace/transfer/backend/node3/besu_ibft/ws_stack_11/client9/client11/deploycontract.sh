#!/bin/sh

cd "$(dirname "$0")"

cd deploy

../poa/bin/python3 deploy.py
