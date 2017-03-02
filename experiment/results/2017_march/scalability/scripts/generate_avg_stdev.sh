#!/usr/bin/env bash

export OUTPUT=../outputs/avg_stdev.dat

./stats.lua ../data/results-1-workers.dat | awk '{print "1 "$1" "$2}' >  $OUTPUT
./stats.lua ../data/results-2-workers.dat | awk '{print "2 "$1" "$2}' >> $OUTPUT
./stats.lua ../data/results-4-workers.dat | awk '{print "4 "$1" "$2}' >> $OUTPUT

./plot.gp

export OUTPUT=../outputs/avg_stdev_sgx.dat

./stats.lua ../data/results-1-workers-sgx.dat | awk '{print "1 "$1" "$2}' >  $OUTPUT
./stats.lua ../data/results-2-workers-sgx.dat | awk '{print "2 "$1" "$2}' >> $OUTPUT
./stats.lua ../data/results-4-workers-sgx.dat | awk '{print "4 "$1" "$2}' >> $OUTPUT

./plot.gp
