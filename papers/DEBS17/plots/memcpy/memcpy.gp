set term post color eps 22 enhanced
set output "memcpy.eps"
load "../styles.inc"

set size 1.2,1.0
set logscale xy
set xtics nomirror
set ytics nomirror
set xlabel 'chunk size (bytes)
set ylabel 'time (s)'
set format xy "10^{%T}"
set label "{/Helvetica=15 64KB}" at 4e+4,2 
set arrow from 65536,0.01 to 65536,1.3 nohead lc rgb 'gray60'
plot \
    'memcpy.dat' u 1:2 w lp ls 10 t "SGX in", \
    'memcpy.dat' u 1:6 w lp ls 21 t "Native in", \
    'memcpy.dat' u 1:4 w lp ls 2 t "SGX in/out", \
    'memcpy.dat' u 1:8 w lp ls 11 t "Native in/out"
