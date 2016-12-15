set term postscript monochrome eps enhanced 22
set output "tput_upload.eps"

set size 1.0,0.65

set bmargin 3.5
set tmargin 2
set lmargin 
set rmargin 3
set grid x y front
set ylabel "Upload Throghput\nKB/sec" offset 0.5,0
#delta between each day: 93982
set xtics ("day-67" 899244006, "" 899337988, "day-69" 899431971, "" 899525953, "day-71" 899619937, "" 899713919, "day-73" 899807902, "" 899901884, "day-75" 899995868) 
set yrange [0:20]
set xrange [:899995868]

#set ytics ("0" 0, "1K" 1000,"2K" 2000,"3K" 3000,"4K" 4000,"5K" 5000)
set key outside horizontal right samplen 2

plot \
  	'data/tput_upload_percentiles.txt' every 10 using 1:($6) with filledcurves x1 ls 10 fillstyle solid 0.1 title "Max",\
	'data/tput_upload_percentiles.txt' every 10 using 1:($5) with filledcurves x1 ls 10 fillstyle solid 0.25 title "75^{th}",\
	'data/tput_upload_percentiles.txt' every 10 using 1:($4) with filledcurves x1 ls 10 fillstyle solid 0.5 title "50^{th}",\
	'data/tput_upload_percentiles.txt' every 10 using 1:($3) with filledcurves x1 ls 10 fillstyle solid 0.85 title "25^{th}",\
	'data/tput_upload_percentiles.txt' every 10 using 1:($2) with filledcurves x1 ls 10 fillstyle solid 0.0 title "Min"

!epstopdf "tput_upload.eps"
!rm "tput_upload.eps"
quit
