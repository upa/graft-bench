set terminal pdf enhanced color fontscale 0.5
set output "graph/graph-zmq-eachthr".rev."-mps.pdf"
set termoption noenhanced

set ylabel "Message per second (Mmps)"
set xlabel "Message size (Byte)"
set size ratio 0.3
set key top right



plot	"dat/nat-eachthr".rev.".dat" using 0:($4)/1000000:xtic(1) \
	with lp title " NAT",	\
	"dat/graft-eachthr".rev.".dat" using 0:($4)/1000000 \
	with lp title " AF_GRAFT"


