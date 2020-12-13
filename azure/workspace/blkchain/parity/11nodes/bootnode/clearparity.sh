#!/bin/sh

rm -rf ./datadir/cache

rm -rf ./datadir/chains

pgrep -f parity | xargs kill -9
