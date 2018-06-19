set terminal pdf enhanced color fontscale 0.77
set output "graph/graph-nginx-siege-bps-conc-".conc.".pdf"

set termoption noenhanced


set ylabel "Throughput (Gbps)"
set xlabel "File size (byte)"
set size ratio 0.40
set key top left



plot	"dat/throughput-graft-conc-".conc.".dat"	\
	using 0:($2 /1000 * 8):xtic(1) \
	with lp title "  GRAFT",	\
	"dat/throughput-nat-conc-".conc.".dat"	\
	using 0:($2 / 1000 * 8) \
	with lp title "  NAT"
