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
set label "{/Helvetica=15 dhrystone}" at 0.8,-5
set label "{/Helvetica=15 fannkuchredux}" at 4.9,-5
set label "{/Helvetica=15 nbody}" at 11.8,-5
set label "{/Helvetica=15 richards}" at 16,-5
set label "{/Helvetica=15 spectralnorm}" at 20.5,-5
set origin 0.072, Y_MARGIN+(Y_POS*(HEIGHT_IND+WIDTH_BETWEEN_Y))
set size 0.8,0.7

rgb(r,g,b) = 65536 * int(r) + 256 * int(g) + int(b)
plot  "data/luabench_1ntv" using 1:2:(rgb($4,$5,$6)) w boxes fs pattern 1 lc rgbcolor variable, \
      "data/luabench_1sgx" using 1:2:(rgb($4,$5,$6)) w boxes fs pattern 2 lc rgbcolor variable

X_POS=1
Y_POS=0

set xrange [0:5]
unset key
unset ylabel
unset label
unset ytics
set y2tics
set grid y2
set label "{/Helvetica=15 binarytrees}" at 0.9,-20
#set title "tidi" offset 0,-0.8
set origin 0.75, Y_MARGIN+(Y_POS*(HEIGHT_IND+WIDTH_BETWEEN_Y))
set size 0.26,0.7

rgb(r,g,b) = 65536 * int(r) + 256 * int(g) + int(b)
plot  "data/luabench_2ntv" using 1:2:(rgb($4,$5,$6)) w boxes fs pattern 1 lc rgbcolor variable axes x1y2,\
      "data/luabench_2sgx" using 1:2:(rgb($4,$5,$6)) w boxes fs pattern 2 lc rgbcolor variable axes x1y2

!epstopdf microbenchmark_luasgx.eps
