set terminal pdf enhanced color fontscale 2.4
set output "graph/graph-zmq-bps-".direct.".pdf"
set termoption noenhanced


set linetype 1 lc rgb "#009e73" lw 1
set linetype 2 lc rgb "#56b4e9" lw 1
set linetype 3 lc rgb "#e69f00" lw 1
set linetype 4 lc rgb "#f0e442" lw 1
set linetype 5 lc rgb "#0072b2" lw 1
set linetype 6 lc rgb "#e54e40" lw 1
set linetype 7 lc rgb "black"   lw 1
set linetype 8 lc rgb "gray50"  lw 1
set linetype 9 lc rgb "dark-violet" lw 1
set linetype cycle  9

set grid ytic
set ylabel "Throughput"
set size ratio 0.7

set yrange [0:]

plot	"dat/nat-bps-".direct.".dat"	\
	using 1:2 with lp lc 1 lw 4 title "NAT"	\
	"dat/graft-bps-".direct.".dat"	\
	using 1:2 with lp lc 2 lw 4 title "GRAFT"

