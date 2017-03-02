set term post color eps 22 enhanced
set output "memcpy.eps"
load "../styles.inc"

set size 1.2,1.0
set logscale xy
set xtics nomirror
set ytics nomirror
set y2tics
set xlabel 'chunk size (bytes)
set ylabel 'time (ms)'
set format xy "10^%T"
plot \
    'memcpy.dat' u (104857600/$1):($3/1e+6) w lp ls 10 t "SGX", \
    'memcpy.dat' u (104857600/$1):($6/1e+6) w lp ls 11 t "Native", \
    'memcpy.dat' u (104857600/$1):($3/$6) w lp ls 12 axes x1y2 t 'Ratio (right-side scale)'
