#!/usr/bin/env gnuplot

set terminal png
set output system('echo "$OUTPUT" | sed s/dat/png/')
set title 'Processing time: Average and standard deviation'
set xlabel '# of workers'
set ylabel 'Processing time (s)'
set logscale x
set boxwidth 0.4 relative

plot [0.7:6] [0:320] system('echo $OUTPUT') using 1:2:3:xtic(1) with boxerror notitle
