#!/usr/bin/env bash

export OUTPUT=../outputs/avg_stdev.dat

./stats.lua ../datas/1-data-1-worker.dat  | awk '{print "1 "$1" "$2}' >  $OUTPUT
./stats.lua ../datas/1-data-2-workers.dat | awk '{print "2 "$1" "$2}' >> $OUTPUT
./stats.lua ../datas/1-data-4-workers.dat | awk '{print "4 "$1" "$2}' >> $OUTPUT

./plot.gp

export OUTPUT=../outputs/avg_stdev_4_streams.dat

./stats.lua ../datas/4-datas-1-worker.dat  | awk '{print "1 "$1" "$2}' >  $OUTPUT
./stats.lua ../datas/4-datas-2-workers.dat | awk '{print "2 "$1" "$2}' >> $OUTPUT
./stats.lua ../datas/4-datas-4-workers.dat | awk '{print "4 "$1" "$2}' >> $OUTPUT

./plot.gp

export OUTPUT=../outputs/avg_stdev_4_streams-1vs2-routers.dat
export OUTPUT1=../outputs/avg_stdev_4_streams-1-routers.dat
export OUTPUT2=../outputs/avg_stdev_4_streams-2-routers.dat

./stats.lua ../datas/4-datas-2-workers.dat | awk '{print "2 "$1" "$2}' > $OUTPUT1
./stats.lua ../datas/4-datas-4-workers.dat | awk '{print "4 "$1" "$2}' >> $OUTPUT1

./stats.lua ../datas/4-datas-2-routers-2-workers.dat | awk '{print "2 "$1" "$2}' >  $OUTPUT2
./stats.lua ../datas/4-datas-2-routers-4-workers.dat | awk '{print "4 "$1" "$2}' >> $OUTPUT2

./plot2.gp
