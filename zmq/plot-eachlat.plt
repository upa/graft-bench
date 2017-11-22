set terminal pdf enhanced color fontscale 0.45
set termoption noenhanced
set output "graph/graph-zmq-eachlat.pdf"

set bmargin 3.5

set ylabel "Latency (us)"
set xlabel "Message size (Byte)"
set size ratio 0.3

set yrange [0:]
set key top left


set xtics offset 1

plot	"dat/nat-eachlat.dat" using 0:2:xtic(1) \
	with lp title "  NAT",	\
	"dat/graft-eachlat.dat"	using 0:2 \
	with lp title "  AF_GRAFT" 

