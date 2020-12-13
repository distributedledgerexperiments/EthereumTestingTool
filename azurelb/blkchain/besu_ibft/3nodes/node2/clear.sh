#!/bin/sh

rm -rf datadir/caches

rm -rf datadir/database

pgrep -f java | xargs kill -9
