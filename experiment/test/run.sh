#!/usr/bin/env bash

echo 'Update source files...'
cp -f ../data-stream.lua data-stream.lua
cp -f ../map-csv-to-event.lua map-csv-to-event.lua
cp -f ../filter-event.lua filter-event.lua
cp -f ../reduce-events.lua reduce-events.lua
cp -f ../print-results.lua print-results.lua
cp -f ../router.lua router.lua

mkdir -p logs
echo 'Clean routing logs...'
rm -f logs/*

docker-compose scale routerdatamapper=1 routermapperfilter=1 routerfilterreduce=1 routerreduceprinter=1
docker-compose scale mapper=4 filter=4 reduce=1
docker-compose up -d data
docker-compose up printer
