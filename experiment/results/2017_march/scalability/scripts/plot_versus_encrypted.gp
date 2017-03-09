#!/usr/bin/env gnuplot

set terminal png
name_png=system('echo "$OUTPUT" | sed s/dat/png/')
set output name_png
set title 'Processing time on encrypted data: Average and standard deviation'
set xlabel '# of workers by processing step'
set ylabel 'Processing time (s)'
set xtics nomirror out ('1' 0,'2' 1,'4' 2)


# color definitions
set border linewidth 1.5
set style line 1 lc rgb 'gray30' lt 1 lw 0.5
set style line 2 lc rgb 'gray40' lt 1 lw 2
set style line 3 lc rgb 'gray70' lt 1 lw 2
set style line 4 lc rgb 'gray90' lt 1 lw 2
set style line 5 lc rgb 'black' lt 1 lw 1.5

set style fill solid 0.5 border rgb 'gray10'

# Size of one box
bs = 0.2


name_data_file=system('echo $OUTPUT')

plot [-0.5:2.5] [0:] \
  name_data_file i 0 u ($0-bs/2):($1):(bs) t 'w/o SGX' w boxes, \
  name_data_file i 0 u ($0-bs/2):($1):($2) notitle w yerrorb ls 1, \
  name_data_file i 1 u ($0+bs/2):($1):(bs) t 'w/ SGX' w boxes, \
  name_data_file i 1 u ($0+bs/2):($1):($2) notitle w yerrorb ls 1

set terminal postscript color portrait size 6,4
name_eps=system('echo "$OUTPUT" | sed s/dat/eps/')
set output name_eps

replot
!epstopdf `echo "$OUTPUT" | sed s/dat/eps/`
!rm `echo "$OUTPUT" | sed s/dat/eps/`

quit
