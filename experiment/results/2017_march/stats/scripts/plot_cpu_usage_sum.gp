#!/usr/bin/env gnuplot


set terminal png
name_png=system('echo "$OUTPUT_DIR/cpu_usage_sum_$XP.png"')
set output name_png

set ylabel "CPU total usage\n% per CPU" offset 0.5,0
set grid x y front

name_data_file=system('echo "$DATA_DIR/$XP/cpu_usage_sum_$XP.txt"')

plot \
  name_data_file every 10 using 1:($2) with filledcurves x1 ls 10 fillstyle solid 0.1 notitle

set term postscript monochrome eps enhanced 22
name_eps=system('echo "$OUTPUT_DIR/cpu_usage_sum_$XP.eps"')
set output name_eps

set size 1.0,0.65

set bmargin 3.5
set tmargin 2
set lmargin
set rmargin 3
#delta between each day: 93982
#set xtics ("day-67" 899244006, "" 899337988, "day-69" 899431971, "" 899525953, "day-71" 899619937, "" 899713919, "day-73" 899807902, "" 899901884, "day-75" 899995868)
set yrange [0:]
set xrange [:]

#set ytics ("0" 0, "1K" 1000,"2K" 2000,"3K" 3000,"4K" 4000,"5K" 5000)
set key outside horizontal right samplen 2

replot

!epstopdf `echo "$OUTPUT_DIR/cpu_usage_sum_$XP.eps"`
!rm `echo "$OUTPUT_DIR/cpu_usage_sum_$XP.eps"`

quit
