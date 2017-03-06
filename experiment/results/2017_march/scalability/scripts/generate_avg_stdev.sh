#!/usr/bin/env bash

echo "Generate plots for XP w/o SGX"

export OUTPUT=../outputs/avg_stdev.dat

./stats.lua ../data/results-1-workers.dat | awk '{print "1 "$1" "$2}' >  $OUTPUT
./stats.lua ../data/results-2-workers.dat | awk '{print "2 "$1" "$2}' >> $OUTPUT
./stats.lua ../data/results-4-workers.dat | awk '{print "4 "$1" "$2}' >> $OUTPUT

./plot.gp


echo "Generate plots for XP w/ mapper SGX"

export OUTPUT=../outputs/avg_stdev_mappersgx.dat

./stats.lua ../data/results-1-workers-mappersgx.dat | awk '{print "1 "$1" "$2}' >  $OUTPUT
./stats.lua ../data/results-2-workers-mappersgx.dat | awk '{print "2 "$1" "$2}' >> $OUTPUT
./stats.lua ../data/results-4-workers-mappersgx.dat | awk '{print "4 "$1" "$2}' >> $OUTPUT

./plot.gp


echo "Generate plots for XP w/ full SGX"

export OUTPUT=../outputs/avg_stdev_fullsgx.dat

./stats.lua ../data/results-1-workers-fullsgx.dat | awk '{print "1 "$1" "$2}' >  $OUTPUT
./stats.lua ../data/results-2-workers-fullsgx.dat | awk '{print "2 "$1" "$2}' >> $OUTPUT
./stats.lua ../data/results-4-workers-fullsgx.dat | awk '{print "4 "$1" "$2}' >> $OUTPUT

./plot.gp


echo "Generate plots for w/o SGX vs w/ SGX"

export OUTPUT=../outputs/avg_stdev_versus.dat

echo "#workers avg std_dev" > $OUTPUT
echo "# w/o SGX" >> $OUTPUT
./stats.lua ../data/results-1-workers.dat     | awk '{print $1" "$2}' >> $OUTPUT
./stats.lua ../data/results-2-workers.dat     | awk '{print $1" "$2}' >> $OUTPUT
./stats.lua ../data/results-4-workers.dat     | awk '{print $1" "$2}' >> $OUTPUT
echo -e "\n\n# w/ mapper SGX" >> $OUTPUT
./stats.lua ../data/results-1-workers-mappersgx.dat | awk '{print $1" "$2}' >> $OUTPUT
./stats.lua ../data/results-2-workers-mappersgx.dat | awk '{print $1" "$2}' >> $OUTPUT
./stats.lua ../data/results-4-workers-mappersgx.dat | awk '{print $1" "$2}' >> $OUTPUT
echo -e "\n\n# w/ full SGX" >> $OUTPUT
./stats.lua ../data/results-1-workers-fullsgx.dat | awk '{print $1" "$2}' >> $OUTPUT
./stats.lua ../data/results-2-workers-fullsgx.dat | awk '{print $1" "$2}' >> $OUTPUT
./stats.lua ../data/results-4-workers-fullsgx.dat | awk '{print $1" "$2}' >> $OUTPUT

./plot_versus.gp
