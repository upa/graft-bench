set terminal pdf enhanced color fontscale 0.80
set termoption noenhanced
set output "graph/graph-zmq-eachlat-rate-256.pdf"


set ylabel "Latency (us)"
set xlabel "Message size (Byte)"
set size ratio 0.35

set ytics 50

set y2tics 
set y2label "Decreasing rate (%)"
set y2range [0:60]

set yrange [0:]
set key top left


set xtics offset 1

plot	"dat/graft-eachlat.dat"	\
	every ::0::12 using 0:2:xtic(1) \
	with lp title "  GRAFT",	\
	"dat/nat-eachlat.dat" \
	every ::0::12 using 0:2 \
	with lp title "  NAT",	\
	"dat/eachlat-reduce-rate.dat"	\
	every ::0::12 using 0:2 axis x1y2 with lp title "  decreasing rate"


