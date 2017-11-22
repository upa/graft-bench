set terminal pdf enhanced color fontscale 0.8
set termoption noenhanced
set output "graph/graph-zmq-eachlat-low.pdf"

#set bmargin 3.0
#set rmargin 3.5



set ylabel "Latency (us)"
set xlabel "Message size (Byte)"
set size ratio 0.5

set yrange [0:]
set key top left



plot	"dat/nat-eachlat.dat" every 1::0::12 using 0:2:xtic(1) \
	with lp title "  NAT",	\
	"dat/graft-eachlat.dat"	every 1::0::12 using 0:2 \
	with lp title "  AF_GRAFT" 

