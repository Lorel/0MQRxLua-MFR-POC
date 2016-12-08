#!/usr/bin/env bash

export OUTPUT=../outputs/avg_stdev.dat

./stats.lua ../datas/1-data-1-worker.dat  | awk '{print "1 "$1" "$2}' >  $OUTPUT
./stats.lua ../datas/1-data-2-workers.dat | awk '{print "2 "$1" "$2}' >> $OUTPUT
./stats.lua ../datas/1-data-4-workers.dat | awk '{print "4 "$1" "$2}' >> $OUTPUT

./plot.gp
