#!/usr/bin/env sh

echo "Parsing raw data files..."

INPUT=../data ../../../../../store_stats/parse_raw_stats.rb

echo "Done!"
