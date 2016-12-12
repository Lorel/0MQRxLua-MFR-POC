#!/usr/bin/env gnuplot

set terminal png
name_png=system('echo "$OUTPUT" | sed s/dat/png/')
set output name_png
set title 'Processing time: Average and standard deviation'
set xlabel '# of workers'
set ylabel 'Processing time (s)'
set logscale x
set boxwidth 0.4 relative

plot [1.4:6] [0:700] system('echo $OUTPUT1') using 1:2:3:xtic(1) with boxerror title 'using 1 router', \
  system('echo $OUTPUT2') using 1:2:3:xtic(1) with boxerror title 'using 2 routers'


set terminal postscript color portrait size 6,4
name_eps=system('echo "$OUTPUT" | sed s/dat/eps/')
set output name_eps

replot
!epstopdf `echo "$OUTPUT" | sed s/dat/eps/`
!rm `echo "$OUTPUT" | sed s/dat/eps/`

quit
