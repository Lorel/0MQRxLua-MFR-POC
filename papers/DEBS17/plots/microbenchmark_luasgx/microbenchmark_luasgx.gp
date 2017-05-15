set term postscript color eps enhanced 22
set output "microbenchmark_luasgx.eps"
load "../styles.inc"

X_MARGIN=0.10
Y_MARGIN=0.04
WIDTH_IND=0.475
HEIGHT_IND=0.5
WIDTH_BETWEEN_X=0.01
WIDTH_BETWEEN_Y=-0.05
NTVPATT=3
SGXPATT=6

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
set label "{/Helvetica=22 dhry}" at 2,-5
set label "{/Helvetica=22 stone}" at 1.7,-12
set label "{/Helvetica=22 fannkuch}" at 5.2,-5
set label "{/Helvetica=22 redux}" at 6,-12
set label "{/Helvetica=22 nbody}" at 11,-5
set label "{/Helvetica=22 richards}" at 15.5,-5
set label "{/Helvetica=22 spectral}" at 20.5,-5
set label "{/Helvetica=22 norm}" at 21,-12
set origin 0.072, Y_MARGIN+(Y_POS*(HEIGHT_IND+WIDTH_BETWEEN_Y))
set size 0.8,0.7

set style fill pattern
rgb(r,g,b) = 65536 * int(r) + 256 * int(g) + int(b)
plot  \
      "data/luabench_1ntv" using 1:2:3:(rgb($4,$5,$6)) w boxerror fill pattern NTVPATT border rgb 'black' lc rgbcolor variable, \
      "data/luabench_1sgx" using 1:2:3:(rgb($4,$5,$6)) w boxerror fill pattern SGXPATT border rgb 'black' lc rgbcolor variable

X_POS=1
Y_POS=0

set xrange [0:5]
unset key
unset ylabel
unset label
unset ytics
set y2tics
set grid y2
set label "{/Helvetica=22 binary}" at 1,-20
set label "{/Helvetica=22 trees}" at 1.2,-50
#set title "tidi" offset 0,-0.8
set origin 0.75, Y_MARGIN+(Y_POS*(HEIGHT_IND+WIDTH_BETWEEN_Y))
set size 0.26,0.7

rgb(r,g,b) = 65536 * int(r) + 256 * int(g) + int(b)
plot  \
      "data/luabench_2sgx" using 1:2:3:(rgb($4,$5,$6)) w boxerror fill pattern SGXPATT border rgb 'black' lc rgbcolor variable axes x1y2, \
      "data/luabench_2ntv" using 1:2:3:(rgb($4,$5,$6)) w boxerror fill pattern NTVPATT border rgb 'black' lc rgbcolor var axes x1y2

set key top left horizontal reverse Left samplen 1.5 width -20
unset border
unset tics
set origin 0.3, 0.15
set size 0.6,0.7
plot \
        [0:1] [0:1] \
        NaN w boxerror fill pattern SGXPATT border rgb 'black' t 'SGX' lc rgb 'gray50', \
        NaN w boxerror fill pattern NTVPATT border rgb 'black' t 'Native' lc rgb 'gray50'

!epstopdf microbenchmark_luasgx.eps
