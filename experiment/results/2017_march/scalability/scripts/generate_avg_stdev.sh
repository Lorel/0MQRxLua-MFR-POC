#!/usr/bin/env bash

echo "Generate plots for XP w/o SGX"

export OUTPUT=../outputs/avg_stdev.dat

./stats.lua ../data/results-1-workers.dat | awk '{print "1 "$1" "$2}' >  $OUTPUT
./stats.lua ../data/results-2-workers.dat | awk '{print "2 "$1" "$2}' >> $OUTPUT
./stats.lua ../data/results-4-workers.dat | awk '{print "4 "$1" "$2}' >> $OUTPUT

./plot.gp

echo "Generate plots for XP w/ SGX"

export OUTPUT=../outputs/avg_stdev_sgx.dat

./stats.lua ../data/results-1-workers-sgx.dat | awk '{print "1 "$1" "$2}' >  $OUTPUT
./stats.lua ../data/results-2-workers-sgx.dat | awk '{print "2 "$1" "$2}' >> $OUTPUT
./stats.lua ../data/results-4-workers-sgx.dat | awk '{print "4 "$1" "$2}' >> $OUTPUT

./plot.gp

echo "Generate plots for w/o SGX vs w/ SGX"

export OUTPUT=../outputs/avg_stdev_versus.dat

echo "#workers avg std_dev" > $OUTPUT
echo "# w/o SGX" >> $OUTPUT
./stats.lua ../data/results-1-workers.dat     | awk '{print $1" "$2}' >> $OUTPUT
./stats.lua ../data/results-2-workers.dat     | awk '{print $1" "$2}' >> $OUTPUT
./stats.lua ../data/results-4-workers.dat     | awk '{print $1" "$2}' >> $OUTPUT
echo -e "\n\n# w/ SGX" >> $OUTPUT
./stats.lua ../data/results-1-workers-sgx.dat | awk '{print $1" "$2}' >> $OUTPUT
./stats.lua ../data/results-2-workers-sgx.dat | awk '{print $1" "$2}' >> $OUTPUT
./stats.lua ../data/results-4-workers-sgx.dat | awk '{print $1" "$2}' >> $OUTPUT

./plot_versus.gp