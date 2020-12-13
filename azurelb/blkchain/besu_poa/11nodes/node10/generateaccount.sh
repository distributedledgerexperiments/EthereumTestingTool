#!/bin/sh

./besu/bin/besu --data-path=datadir public-key export-address --to=datadir/nodeAddress

more datadir/key

more datadir/nodeAddress
