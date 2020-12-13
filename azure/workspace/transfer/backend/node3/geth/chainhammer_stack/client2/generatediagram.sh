#!/bin/sh

cd "$(dirname "$0")"

cd chainreader

rm -rf allblocks.db

rm -rf allblocks.db.sql

python3 blocksDB_create.py

jupyter notebook blocksDB_analyze_geth-clique.ipynb --ip=10.214.226.37
