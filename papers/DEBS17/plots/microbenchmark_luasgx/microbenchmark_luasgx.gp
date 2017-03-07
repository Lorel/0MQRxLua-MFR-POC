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

set xrange [0:15]
set xtics 25 offset 0,0.3
set mxtics 5

set style data histogram
set style fill solid
set datafile missing '-'
set style fill solid 0.5
set boxwidth 0.7

# Labels
set xtics font "Arial,15" #offset +0.5 #rotate by -90
set grid noxtics
set grid y
set key autotitle columnhead
#unset key

set xlabel "{/Helvetica=22 Time (seconds)}" offset 0,0.7

X_POS=0
Y_POS=0

set ylabel "run time (s)" offset 1.5,0
set title "tada" offset 0,-0.8
set origin X_MARGIN+(X_POS*(WIDTH_IND+WIDTH_BETWEEN_X)), Y_MARGIN+(Y_POS*(HEIGHT_IND+WIDTH_BETWEEN_Y))
set size WIDTH_IND,HEIGHT_IND

rgb(r,g,b) = 65536 * int(r) + 256 * int(g) + int(b)
plot  "data/ratio.txt"   using  1:2:(rgb($3,$4,$5)) w boxes lc rgbcolor variable,\
     1 with lines linecolor 0 linetype 6;


X_POS=0
Y_POS=1

set title "todo" offset 0,-0.8
set origin X_MARGIN+(X_POS*(WIDTH_IND+WIDTH_BETWEEN_X)), Y_MARGIN+(Y_POS*(HEIGHT_IND+WIDTH_BETWEEN_Y))
set size WIDTH_IND,HEIGHT_IND/2
set xrange [0:10]
rgb(r,g,b) = 65536 * int(r) + 256 * int(g) + int(b)
plot  "data/ratio.txt"   using  1:2:(rgb($3,$4,$5)) w boxes lc rgbcolor variable,\
     1 with lines linecolor 0 linetype 6;

X_POS=1
Y_POS=0
unset label 1001
unset key
unset ylabel
set title "todo" offset 0,-0.8
set origin X_MARGIN+(X_POS*(WIDTH_IND+WIDTH_BETWEEN_X)), Y_MARGIN+(Y_POS*(HEIGHT_IND+WIDTH_BETWEEN_Y))
set size WIDTH_IND,HEIGHT_IND

rgb(r,g,b) = 65536 * int(r) + 256 * int(g) + int(b)
plot  "data/ratio.txt"   using  1:2:(rgb($3,$4,$5)) w boxes lc rgbcolor variable,\
     1 with lines linecolor 0 linetype 6;


X_POS=1
Y_POS=1

set title "todo" offset 0,-0.8
set origin X_MARGIN+(X_POS*(WIDTH_IND+WIDTH_BETWEEN_X)), Y_MARGIN+(Y_POS*(HEIGHT_IND+WIDTH_BETWEEN_Y))
set size WIDTH_IND,HEIGHT_IND/2
unset ytics
set xrange [0:10]
rgb(r,g,b) = 65536 * int(r) + 256 * int(g) + int(b)
plot  "data/ratio.txt"   using  1:2:(rgb($3,$4,$5)) w boxes lc rgbcolor variable,\
     1 with lines linecolor 0 linetype 6;

     
!epstopdf microbenchmark_luasgx.eps
