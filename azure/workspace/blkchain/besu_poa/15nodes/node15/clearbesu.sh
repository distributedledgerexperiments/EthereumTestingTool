#!/bin/sh

cd datadir

rm -rf database

rm -rf caches


pgrep -f java | xargs kill -9
