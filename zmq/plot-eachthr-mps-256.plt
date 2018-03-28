set terminal pdf enhanced color fontscale 0.85
set output "graph/graph-zmq-eachthr".rev."-mps-256.pdf"
set termoption noenhanced

set ylabel "Message per second (Mmps)"
set xlabel "Message size (Byte)"
set size ratio 0.4
set key top right



plot	"dat/graft-eachthr".rev.".dat" \
	every ::0::12 using 0:($4)/1000000 \
	with lp title " GRAFT",	\
	"dat/nat-eachthr".rev.".dat" \
	every ::0::12 using 0:($4)/1000000:xtic(1) \
	with lp title " NAT"

