#!/usr/bin/env gnuplot


set term postscript monochrome eps enhanced 22
set xlabel "Time (seconds)"
set ylabel "Upload Throughput (MB/sec)" offset 0.5,0
set grid x y front
set size 1.0,0.85

set bmargin 3.5
set tmargin 2
set lmargin
set rmargin 3

set key outside horizontal right samplen 2


set output 'tput_tx_percentiles_1-workers.eps'
set yrange [0:25]
set xrange [0:420]
set ytics 5

plot \
  'data/tput_tx_percentiles_1-workers.txt' every 10 using 1:($6/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.1 title "Max",\
  'data/tput_tx_percentiles_1-workers.txt' every 10 using 1:($5/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.25 title "75^{th}",\
  'data/tput_tx_percentiles_1-workers.txt' every 10 using 1:($4/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.5 title "50^{th}",\
  'data/tput_tx_percentiles_1-workers.txt' every 10 using 1:($3/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.85 title "25^{th}",\
  'data/tput_tx_percentiles_1-workers.txt' every 10 using 1:($2/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.0 title "Min"

!epstopdf 'tput_tx_percentiles_1-workers.eps'
!rm 'tput_tx_percentiles_1-workers.eps'


set output 'tput_tx_percentiles_1-workers-fullsgx.eps'
set yrange [0:]
set xrange [:]
set ytics 1

plot \
  'data/tput_tx_percentiles_1-workers-fullsgx.txt' every 10 using 1:($6/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.1 title "Max",\
  'data/tput_tx_percentiles_1-workers-fullsgx.txt' every 10 using 1:($5/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.25 title "75^{th}",\
  'data/tput_tx_percentiles_1-workers-fullsgx.txt' every 10 using 1:($4/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.5 title "50^{th}",\
  'data/tput_tx_percentiles_1-workers-fullsgx.txt' every 10 using 1:($3/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.85 title "25^{th}",\
  'data/tput_tx_percentiles_1-workers-fullsgx.txt' every 10 using 1:($2/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.0 title "Min"

!epstopdf tput_tx_percentiles_1-workers-fullsgx.eps
!rm tput_tx_percentiles_1-workers-fullsgx.eps


set output 'tput_tx_percentiles_2-workers.eps'
set yrange [0:25]
set xrange [0:420]
set ytics 5

plot \
  'data/tput_tx_percentiles_2-workers.txt' every 10 using 1:($6/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.1 title "Max",\
  'data/tput_tx_percentiles_2-workers.txt' every 10 using 1:($5/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.25 title "75^{th}",\
  'data/tput_tx_percentiles_2-workers.txt' every 10 using 1:($4/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.5 title "50^{th}",\
  'data/tput_tx_percentiles_2-workers.txt' every 10 using 1:($3/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.85 title "25^{th}",\
  'data/tput_tx_percentiles_2-workers.txt' every 10 using 1:($2/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.0 title "Min"

!epstopdf tput_tx_percentiles_2-workers.eps
!rm tput_tx_percentiles_2-workers.eps


set output 'tput_tx_percentiles_2-workers-fullsgx.eps'
set yrange [0:]
set xrange [:]
set ytics 1

plot \
  'data/tput_tx_percentiles_2-workers-fullsgx.txt' every 10 using 1:($6/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.1 title "Max",\
  'data/tput_tx_percentiles_2-workers-fullsgx.txt' every 10 using 1:($5/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.25 title "75^{th}",\
  'data/tput_tx_percentiles_2-workers-fullsgx.txt' every 10 using 1:($4/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.5 title "50^{th}",\
  'data/tput_tx_percentiles_2-workers-fullsgx.txt' every 10 using 1:($3/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.85 title "25^{th}",\
  'data/tput_tx_percentiles_2-workers-fullsgx.txt' every 10 using 1:($2/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.0 title "Min"

!epstopdf tput_tx_percentiles_2-workers-fullsgx.eps
!rm tput_tx_percentiles_2-workers-fullsgx.eps


set output 'tput_tx_percentiles_4-workers.eps'
set yrange [0:25]
set xrange [0:420]
set ytics 5

plot \
  'data/tput_tx_percentiles_4-workers.txt' every 10 using 1:($6/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.1 title "Max",\
  'data/tput_tx_percentiles_4-workers.txt' every 10 using 1:($5/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.25 title "75^{th}",\
  'data/tput_tx_percentiles_4-workers.txt' every 10 using 1:($4/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.5 title "50^{th}",\
  'data/tput_tx_percentiles_4-workers.txt' every 10 using 1:($3/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.85 title "25^{th}",\
  'data/tput_tx_percentiles_4-workers.txt' every 10 using 1:($2/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.0 title "Min"

!epstopdf tput_tx_percentiles_4-workers.eps
!rm tput_tx_percentiles_4-workers.eps


set output 'tput_tx_percentiles_4-workers-fullsgx.eps'
set yrange [0:]
set xrange [:]
set ytics 1

plot \
  'data/tput_tx_percentiles_4-workers-fullsgx.txt' every 10 using 1:($6/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.1 title "Max",\
  'data/tput_tx_percentiles_4-workers-fullsgx.txt' every 10 using 1:($5/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.25 title "75^{th}",\
  'data/tput_tx_percentiles_4-workers-fullsgx.txt' every 10 using 1:($4/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.5 title "50^{th}",\
  'data/tput_tx_percentiles_4-workers-fullsgx.txt' every 10 using 1:($3/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.85 title "25^{th}",\
  'data/tput_tx_percentiles_4-workers-fullsgx.txt' every 10 using 1:($2/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.0 title "Min"

!epstopdf tput_tx_percentiles_4-workers-fullsgx.eps
!rm tput_tx_percentiles_4-workers-fullsgx.eps


set output 'tput_tx_percentiles_1-workers-encrypted-nosgx.eps'
set yrange [0:25]
set xrange [0:800]
set ytics 5

plot \
  'data/tput_tx_percentiles_1-workers-encrypted-nosgx.txt' every 10 using 1:($6/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.1 title "Max",\
  'data/tput_tx_percentiles_1-workers-encrypted-nosgx.txt' every 10 using 1:($5/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.25 title "75^{th}",\
  'data/tput_tx_percentiles_1-workers-encrypted-nosgx.txt' every 10 using 1:($4/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.5 title "50^{th}",\
  'data/tput_tx_percentiles_1-workers-encrypted-nosgx.txt' every 10 using 1:($3/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.85 title "25^{th}",\
  'data/tput_tx_percentiles_1-workers-encrypted-nosgx.txt' every 10 using 1:($2/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.0 title "Min"

!epstopdf 'tput_tx_percentiles_1-workers-encrypted-nosgx.eps'
!rm 'tput_tx_percentiles_1-workers-encrypted-nosgx.eps'


set output 'tput_tx_percentiles_1-workers-encrypted-fullsgx.eps'
set yrange [0:25]
set xrange [0:2150]
set ytics 5

plot \
  'data/tput_tx_percentiles_1-workers-encrypted-fullsgx.txt' every 10 using 1:($6/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.1 title "Max",\
  'data/tput_tx_percentiles_1-workers-encrypted-fullsgx.txt' every 10 using 1:($5/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.25 title "75^{th}",\
  'data/tput_tx_percentiles_1-workers-encrypted-fullsgx.txt' every 10 using 1:($4/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.5 title "50^{th}",\
  'data/tput_tx_percentiles_1-workers-encrypted-fullsgx.txt' every 10 using 1:($3/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.85 title "25^{th}",\
  'data/tput_tx_percentiles_1-workers-encrypted-fullsgx.txt' every 10 using 1:($2/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.0 title "Min"

!epstopdf tput_tx_percentiles_1-workers-encrypted-fullsgx.eps
!rm tput_tx_percentiles_1-workers-encrypted-fullsgx.eps


set output 'tput_tx_percentiles_2-workers-encrypted-nosgx.eps'
set yrange [0:25]
set xrange [0:800]
set ytics 5

plot \
  'data/tput_tx_percentiles_2-workers-encrypted-nosgx.txt' every 10 using 1:($6/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.1 title "Max",\
  'data/tput_tx_percentiles_2-workers-encrypted-nosgx.txt' every 10 using 1:($5/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.25 title "75^{th}",\
  'data/tput_tx_percentiles_2-workers-encrypted-nosgx.txt' every 10 using 1:($4/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.5 title "50^{th}",\
  'data/tput_tx_percentiles_2-workers-encrypted-nosgx.txt' every 10 using 1:($3/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.85 title "25^{th}",\
  'data/tput_tx_percentiles_2-workers-encrypted-nosgx.txt' every 10 using 1:($2/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.0 title "Min"

!epstopdf tput_tx_percentiles_2-workers-encrypted-nosgx.eps
!rm tput_tx_percentiles_2-workers-encrypted-nosgx.eps


set output 'tput_tx_percentiles_2-workers-encrypted-fullsgx.eps'
set yrange [0:25]
set xrange [0:2150]
set ytics 5

plot \
  'data/tput_tx_percentiles_2-workers-encrypted-fullsgx.txt' every 10 using 1:($6/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.1 title "Max",\
  'data/tput_tx_percentiles_2-workers-encrypted-fullsgx.txt' every 10 using 1:($5/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.25 title "75^{th}",\
  'data/tput_tx_percentiles_2-workers-encrypted-fullsgx.txt' every 10 using 1:($4/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.5 title "50^{th}",\
  'data/tput_tx_percentiles_2-workers-encrypted-fullsgx.txt' every 10 using 1:($3/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.85 title "25^{th}",\
  'data/tput_tx_percentiles_2-workers-encrypted-fullsgx.txt' every 10 using 1:($2/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.0 title "Min"

!epstopdf tput_tx_percentiles_2-workers-encrypted-fullsgx.eps
!rm tput_tx_percentiles_2-workers-encrypted-fullsgx.eps


set output 'tput_tx_percentiles_4-workers-encrypted-nosgx.eps'
set yrange [0:25]
set xrange [0:800]
set ytics 5

plot \
  'data/tput_tx_percentiles_4-workers-encrypted-nosgx.txt' every 10 using 1:($6/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.1 title "Max",\
  'data/tput_tx_percentiles_4-workers-encrypted-nosgx.txt' every 10 using 1:($5/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.25 title "75^{th}",\
  'data/tput_tx_percentiles_4-workers-encrypted-nosgx.txt' every 10 using 1:($4/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.5 title "50^{th}",\
  'data/tput_tx_percentiles_4-workers-encrypted-nosgx.txt' every 10 using 1:($3/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.85 title "25^{th}",\
  'data/tput_tx_percentiles_4-workers-encrypted-nosgx.txt' every 10 using 1:($2/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.0 title "Min"

!epstopdf tput_tx_percentiles_4-workers-encrypted-nosgx.eps
!rm tput_tx_percentiles_4-workers-encrypted-nosgx.eps


set output 'tput_tx_percentiles_4-workers-encrypted-fullsgx.eps'
set yrange [0:25]
set xrange [0:2150]
set ytics 5

plot \
  'data/tput_tx_percentiles_4-workers-encrypted-fullsgx.txt' every 10 using 1:($6/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.1 title "Max",\
  'data/tput_tx_percentiles_4-workers-encrypted-fullsgx.txt' every 10 using 1:($5/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.25 title "75^{th}",\
  'data/tput_tx_percentiles_4-workers-encrypted-fullsgx.txt' every 10 using 1:($4/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.5 title "50^{th}",\
  'data/tput_tx_percentiles_4-workers-encrypted-fullsgx.txt' every 10 using 1:($3/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.85 title "25^{th}",\
  'data/tput_tx_percentiles_4-workers-encrypted-fullsgx.txt' every 10 using 1:($2/1024/1024) with filledcurves x1 ls 10 fillstyle solid 0.0 title "Min"

!epstopdf tput_tx_percentiles_4-workers-encrypted-fullsgx.eps
!rm tput_tx_percentiles_4-workers-encrypted-fullsgx.eps

quit
