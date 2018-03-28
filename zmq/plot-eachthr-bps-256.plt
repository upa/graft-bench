set terminal pdf enhanced color fontscale 0.85
set output "graph/graph-zmq-eachthr".rev."-bps-256.pdf"
set termoption noenhanced

set grid ytic
set ylabel "Throughput (Gbps)"
set xlabel "Message size (Byte)"
set size ratio 0.4
set key top left

set yrange [0:]


plot	"dat/graft-eachthr".rev.".dat" \
	every ::0::12	\
	using 0:($2/1000000000):xtic(1) \
	with lp title " GRAFT",	\
	"dat/nat-eachthr".rev.".dat" \
	every ::0::12	\
	using 0:($2/1000000000) \
	with lp title " NAT"	

