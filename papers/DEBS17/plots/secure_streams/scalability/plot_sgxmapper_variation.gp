#!/usr/bin/env gnuplot

set terminal postscript color portrait size 6,4
set output 'sgxmapper_scalability.eps'

set size 1.0,0.8

set title 'Processing time: Average and standard deviation'
set xlabel '# of SGX mappers'
set ylabel 'Processing time (s)'
set logscale x
set boxwidth 0.5 relative
set style fill pattern

plot [0.6:24] [0:] 'data/avg_stdev_mappersgx_variation.dat' using 1:2:3:xtic(1) with boxerror fill pattern 6 border rgb 'black' lc rgb '#5ab4ac' notitle


!epstopdf sgxmapper_scalability.eps
!rm sgxmapper_scalability.eps

quit
