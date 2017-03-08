set term postscript color eps enhanced 22
set output "microbenchmark_luasgx.eps"
load "../styles.inc"

X_MARGIN=0.10
Y_MARGIN=0.04
WIDTH_IND=0.475
HEIGHT_IND=0.5
WIDTH_BETWEEN_X=0.01
WIDTH_BETWEEN_Y=-0.05

set size 1.0,0.8

set bmargin 2
set tmargin 2
set lmargin 2
set rmargin 5

set multiplot

unset key
set grid y
unset xtics
#set xtics 25 offset 0,0.3
#set mxtics 5

set style data histogram
set style fill solid
set datafile missing '-'
set style fill solid 0.5
set boxwidth 1.0

# Labels
#set xtics font "Arial,15" #offset +0.5 #rotate by -90
set grid noxtics
set grid y
#set key autotitle columnhead
#unset key

#set xlabel "{/Helvetica=22 Time (seconds)}" offset 0,0.7

X_POS=0
Y_POS=0

set xrange [0:25]
set ylabel "run time (s)" offset 1.5,0
#set title "tada" offset 0,-0.8
set label "{/Helvetica=17 275 KB}" at 1.1,14
set label "{/Helvetica=17 28 KB}" at 6.1,43
set label "{/Helvetica=17 38 KB}" at 11.1,74
set label "{/Helvetica=17 106 KB}" at 16.3,0.5 rotate by 90
set label "{/Helvetica=17 191 KB}" at 18.3,5 rotate by 90
set label "{/Helvetica=17 52 KB}" at 21.3,2 rotate by 90
set label "{/Helvetica=17 404 KB}" at 23.3,62 rotate by 90
set label "{/Helvetica=15 dhrystone}" at 1,-12 rotate by 30
set label "{/Helvetica=15 fannkuchredux}" at 4.5,-16 rotate by 30
set label "{/Helvetica=15 nbody}" at 11,-8 rotate by 30
set label "{/Helvetica=15 richards}" at 16,-10 rotate by 30
set label "{/Helvetica=15 spectralnorm}" at 20,-15 rotate by 30
set origin X_MARGIN+(X_POS*(WIDTH_IND+WIDTH_BETWEEN_X)), Y_MARGIN+(Y_POS*(HEIGHT_IND+WIDTH_BETWEEN_Y))
set size 0.7,0.7

rgb(r,g,b) = 65536 * int(r) + 256 * int(g) + int(b)
plot  "data/luabench_1" using 1:2:(rgb($4,$5,$6)) w boxes lc rgbcolor variable

X_POS=1
Y_POS=0

set xrange [0:5]
unset key
unset ylabel
unset label
set label "{/Helvetica=17 25 MB}" at 0.1,25
set label "{/Helvetica=17 664 MB}" at 2,380
set label "{/Helvetica=15 binarytrees}" at 0.9,-65 rotate by 30
#set title "tidi" offset 0,-0.8
set origin 0.76, Y_MARGIN+(Y_POS*(HEIGHT_IND+WIDTH_BETWEEN_Y))
set size 0.28,0.7

rgb(r,g,b) = 65536 * int(r) + 256 * int(g) + int(b)
plot  "data/luabench_2" using 1:2:(rgb($4,$5,$6)) w boxes lc rgbcolor variable,\
     1 with lines linecolor 0 linetype 6;

!epstopdf microbenchmark_luasgx.eps
