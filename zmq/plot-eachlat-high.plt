set terminal pdf enhanced color fontscale 0.8
set termoption noenhanced
set output "graph/graph-zmq-eachlat-high.pdf"

set bmargin 3.5

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
set grid ytic dt (10,5) lw 2

set boxwidth 0.7
set style fill solid 0.75
set ylabel "Latency (us)"
set xlabel "Message size (Byte)"
set size ratio 0.5

set yrange [0:]
set key top left

set xtics offset 1

plot	"dat/nat-eachlat.dat" every ::13::19 using ($0)*2:2:xtic(1) \
	with boxes lw 2 lc 1 title "  NAT",	\
	"dat/graft-eachlat.dat"	every ::13::19 using ($0)*2+0.7:2 \
	with boxes lw 2 lc 2 title "  AF_GRAFT" 

