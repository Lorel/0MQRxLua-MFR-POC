#!/usr/bin/env bash

# echo "Generate plots for XP w/o SGX"
#
# export OUTPUT=../outputs/avg_stdev.dat
#
# ./stats.lua ../data/results-1-workers.dat | awk '{print "1 "$1" "$2}' >  $OUTPUT
# ./stats.lua ../data/results-2-workers.dat | awk '{print "2 "$1" "$2}' >> $OUTPUT
# ./stats.lua ../data/results-4-workers.dat | awk '{print "4 "$1" "$2}' >> $OUTPUT
#
# ./plot.gp
#
#
# echo "Generate plots for XP w/ mapper SGX"
#
# export OUTPUT=../outputs/avg_stdev_mappersgx.dat
#
# ./stats.lua ../data/results-1-workers-mappersgx.dat | awk '{print "1 "$1" "$2}' >  $OUTPUT
# ./stats.lua ../data/results-2-workers-mappersgx.dat | awk '{print "2 "$1" "$2}' >> $OUTPUT
# ./stats.lua ../data/results-4-workers-mappersgx.dat | awk '{print "4 "$1" "$2}' >> $OUTPUT
#
# ./plot.gp
#
#
# echo "Generate plots for XP w/ full SGX"
#
# export OUTPUT=../outputs/avg_stdev_fullsgx.dat
#
# ./stats.lua ../data/results-1-workers-fullsgx.dat | awk '{print "1 "$1" "$2}' >  $OUTPUT
# ./stats.lua ../data/results-2-workers-fullsgx.dat | awk '{print "2 "$1" "$2}' >> $OUTPUT
# ./stats.lua ../data/results-4-workers-fullsgx.dat | awk '{print "4 "$1" "$2}' >> $OUTPUT
#
# ./plot.gp
#
#
# echo "Generate plots for w/o SGX vs w/ SGX"
#
# export OUTPUT=../outputs/avg_stdev_versus.dat
#
# echo "#workers avg std_dev" > $OUTPUT
# echo "# w/o SGX" >> $OUTPUT
# ./stats.lua ../data/results-1-workers.dat     | awk '{print $1" "$2}' >> $OUTPUT
# ./stats.lua ../data/results-2-workers.dat     | awk '{print $1" "$2}' >> $OUTPUT
# ./stats.lua ../data/results-4-workers.dat     | awk '{print $1" "$2}' >> $OUTPUT
# echo -e "\n\n# w/ mapper SGX" >> $OUTPUT
# ./stats.lua ../data/results-1-workers-mappersgx.dat | awk '{print $1" "$2}' >> $OUTPUT
# ./stats.lua ../data/results-2-workers-mappersgx.dat | awk '{print $1" "$2}' >> $OUTPUT
# ./stats.lua ../data/results-4-workers-mappersgx.dat | awk '{print $1" "$2}' >> $OUTPUT
# echo -e "\n\n# w/ full SGX" >> $OUTPUT
# ./stats.lua ../data/results-1-workers-fullsgx.dat | awk '{print $1" "$2}' >> $OUTPUT
# ./stats.lua ../data/results-2-workers-fullsgx.dat | awk '{print $1" "$2}' >> $OUTPUT
# ./stats.lua ../data/results-4-workers-fullsgx.dat | awk '{print $1" "$2}' >> $OUTPUT
#
# ./plot_versus.gp
#
#
# echo "Generate plots for XP w/ mappers SGX variation"
#
# export OUTPUT=../outputs/avg_stdev_mappersgx_variation.dat
#
# ./stats.lua ../data/results-1-workers-mappersgx.dat | awk '{print "1 "$1" "$2}'  >  $OUTPUT
# ./stats.lua ../data/results-1-workers-2-sgx.dat     | awk '{print "2 "$1" "$2}'  >> $OUTPUT
# ./stats.lua ../data/results-1-workers-4-sgx.dat     | awk '{print "4 "$1" "$2}'  >> $OUTPUT
# ./stats.lua ../data/results-1-workers-8-sgx.dat     | awk '{print "8 "$1" "$2}'  >> $OUTPUT
# ./stats.lua ../data/results-1-workers-16-sgx.dat    | awk '{print "16 "$1" "$2}' >> $OUTPUT
#
# ./plot_sgxmapper_variation.gp


echo "Generate plots for XP encrypted w/o SGX"

export OUTPUT=../outputs/avg_stdev_encrypted_nosgx.dat

./stats.lua ../data/results-1-workers-encrypted-nosgx.dat | awk '{print "1 "$1" "$2}' >  $OUTPUT
./stats.lua ../data/results-2-workers-encrypted-nosgx.dat | awk '{print "2 "$1" "$2}' >> $OUTPUT
./stats.lua ../data/results-4-workers-encrypted-nosgx.dat | awk '{print "4 "$1" "$2}' >> $OUTPUT

./plot.gp


echo "Generate plots for XP encrypted w/ SGX"

export OUTPUT=../outputs/avg_stdev_encrypted_fullsgx.dat

./stats.lua ../data/results-1-workers-encrypted-fullsgx.dat | awk '{print "1 "$1" "$2}' >  $OUTPUT
./stats.lua ../data/results-2-workers-encrypted-fullsgx.dat | awk '{print "2 "$1" "$2}' >> $OUTPUT
./stats.lua ../data/results-4-workers-encrypted-fullsgx.dat | awk '{print "4 "$1" "$2}' >> $OUTPUT

./plot.gp


echo "Generate plots for XP encrypted w/o SGX vs w/ SGX"

export OUTPUT=../outputs/avg_stdev_encrypted_versus.dat

echo "#workers avg std_dev encrypted" > $OUTPUT
echo "# w/o SGX" >> $OUTPUT
./stats.lua ../data/results-1-workers-encrypted-nosgx.dat | awk '{print $1" "$2}' >> $OUTPUT
./stats.lua ../data/results-2-workers-encrypted-nosgx.dat | awk '{print $1" "$2}' >> $OUTPUT
./stats.lua ../data/results-4-workers-encrypted-nosgx.dat | awk '{print $1" "$2}' >> $OUTPUT
echo -e "\n\n# w/ SGX" >> $OUTPUT
./stats.lua ../data/results-1-workers-encrypted-fullsgx.dat | awk '{print $1" "$2}' >> $OUTPUT
./stats.lua ../data/results-2-workers-encrypted-fullsgx.dat | awk '{print $1" "$2}' >> $OUTPUT
./stats.lua ../data/results-4-workers-encrypted-fullsgx.dat | awk '{print $1" "$2}' >> $OUTPUT

./plot_versus_encrypted.gp
