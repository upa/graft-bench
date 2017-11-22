set terminal pdf enhanced color fontscale 0.7
set output "graph/graph-zmq-eachthr".rev."-mps-high.pdf"
set termoption noenhanced


set ylabel "Message per second (mps)"
set xlabel "Message size (Byte)"
set size ratio 0.5
set key top right


plot	"dat/nat-eachthr".rev.".dat" \
	every ::12::19 using 0:4:xtic(1) \
	with lp title " NAT",	\
	"dat/graft-eachthr".rev.".dat" \
	every ::12::19 using 0:4 \
	with lp title " AF_GRAFT"


