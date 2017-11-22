set terminal pdf enhanced color fontscale 1
set termoption noenhanced
set output "graph/graph-zmq-eachlat-high.pdf"


set ylabel "Latency (us)"
set xlabel "Message size (Byte)"
set size ratio 0.7

set yrange [0:]
set key top left


plot	"dat/nat-eachlat.dat" every ::14::20 using 0:2:xtic(1) \
	with lp title "  NAT",	\
	"dat/graft-eachlat.dat"	every ::14::20 using 0:2 \
	with lp title "  AF_GRAFT" 

