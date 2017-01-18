#!/usr/bin/env gnuplot

name_eps=system('echo "${OUTPUT_DIR}/tput_upload_${XP}.eps"')
set term postscript monochrome eps enhanced 22
set output name_eps

set size 1.0,0.65

set bmargin 3.5
set tmargin 2
set lmargin
set rmargin 3
set grid x y front
set ylabel "Upload Throghput\nKB/sec" offset 0.5,0
#delta between each day: 93982
#set xtics ("day-67" 899244006, "" 899337988, "day-69" 899431971, "" 899525953, "day-71" 899619937, "" 899713919, "day-73" 899807902, "" 899901884, "day-75" 899995868)
set yrange [0:]
set xrange [:]

#set ytics ("0" 0, "1K" 1000,"2K" 2000,"3K" 3000,"4K" 4000,"5K" 5000)
set key outside horizontal right samplen 2

name_datas_file=system('echo "../datas/${XP}/tput_tx_percentiles_${XP}.txt"')

plot \
  name_datas_file every 10 using 1:($6/1024) with filledcurves x1 ls 10 fillstyle solid 0.1 title "Max",\
	name_datas_file every 10 using 1:($5/1024) with filledcurves x1 ls 10 fillstyle solid 0.25 title "75^{th}",\
	name_datas_file every 10 using 1:($4/1024) with filledcurves x1 ls 10 fillstyle solid 0.5 title "50^{th}",\
	name_datas_file every 10 using 1:($3/1024) with filledcurves x1 ls 10 fillstyle solid 0.85 title "25^{th}",\
	name_datas_file every 10 using 1:($2/1024) with filledcurves x1 ls 10 fillstyle solid 0.0 title "Min"

!epstopdf `echo "${OUTPUT_DIR}/tput_upload_${XP}.eps"`
!rm `echo "${OUTPUT_DIR}/tput_upload_${XP}.eps"`
quit
