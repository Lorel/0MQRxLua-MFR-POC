#!/usr/bin/env bash

cp -f ../data-stream.lua data-stream.lua
cp -f ../map-csv-to-event.lua map-csv-to-event.lua
cp -f ../filter-event.lua filter-event.lua
cp -f ../reduce-events.lua reduce-events.lua
cp -f ../print-results.lua print-results.lua

docker-compose run data
docker logs test_print_1
