set terminal pdf enhanced color fontscale 0.5
set output "graph/graph-zmq-eachthr".rev."-bps.pdf"
set termoption noenhanced
set bmargin 3.5

set grid ytic
set ylabel "Throughput (Gbps)"
set xlabel "Message size (Byte)"
set size ratio 0.3
set key top right

set yrange [0:]


plot	"dat/nat-eachthr".rev.".dat" using 0:($2/1000000000):xtic(1) \
	with lp title " NAT",	\
	"dat/graft-eachthr".rev.".dat" using 0:($2/1000000000) \
	with lp title " AF_GRAFT"

