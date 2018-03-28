set terminal pdf enhanced color fontscale 1.2
set termoption noenhanced
set output "graph/graph-iperf3-c2c-udp.pdf"


set ylabel "Throughput (Gbps)"
set xlabel "packet size (byte)"
set key bottom right

set yrange [0:]
set size ratio 1
set key top left


plot	"dat/c2c-udp-graft.txt"	\
	using 0:2:xtic(1) with lp title "Bridge",	\
	"dat/c2c-udp-bridge.txt"	\
	using 0:2 with lp title "GRAFT"
