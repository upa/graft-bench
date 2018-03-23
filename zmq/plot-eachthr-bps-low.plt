set terminal pdf enhanced color fontscale 1.2
set output "graph/graph-zmq-eachthr".rev."-bps-low.pdf"
set termoption noenhanced
#set bmargin 3.5

set grid ytic
set ylabel "Throughput (Gbps)"
set xlabel "Message size (Byte)"
set size ratio 0.3
set key left top 

set yrange [0:]


plot	"dat/graft-eachthr".rev.".dat" \
	every ::0::13	\
	using 0:($2/1000000000):xtic(1) \
	with lp title " GRAFT",	\
	"dat/nat-eachthr".rev.".dat" \
	every ::0::13	\
	using 0:($2/1000000000) \
	with lp title " NAT"	

