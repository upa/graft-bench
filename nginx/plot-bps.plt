set terminal pdf enhanced color fontscale 0.7
set output "graph/graph-nginx-siege-bps-conc-".conc.".pdf"

set termoption noenhanced


set ylabel "Throughput (Gbps)"
set xlabel "File size (byte)"
set size ratio 0.6
set key top left



plot	"dat/throughput-nat-conc-".conc.".dat"	\
	using 0:($2 / 1000 * 8):xtic(1) \
	with lp title "  NAT",	\
	"dat/throughput-graft-conc-".conc.".dat"	\
	using 0:($2 /1000 * 8) \
	with lp title "  AF_GRAFT"
