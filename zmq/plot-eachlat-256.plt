set terminal pdf enhanced color fontscale 0.85
set termoption noenhanced
set output "graph/graph-zmq-eachlat-256.pdf"


set ylabel "Latency (us)"
set xlabel "Message size (Byte)"
set size ratio 0.35

set yrange [0:]
set key top left


set xtics offset 1

plot	"dat/graft-eachlat.dat"	\
	every ::0::12 using 0:2:xtic(1) \
	with lp title "  AF_GRAFT",	\
	"dat/nat-eachlat.dat" \
	every ::0::12 using 0:2:xtic(1) \
	with lp title "  NAT"

