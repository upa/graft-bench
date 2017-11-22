set terminal pdfcairo enhanced color fontscale 0.7
set output "graph/graph-nginx-siege-tps-conc-".conc.".pdf"

set termoption noenhanced

set ylabel "Transactions per second"
set xlabel "File size (byte)"
set size ratio 0.6


plot	"dat/trans-rate-nat-conc-".conc.".dat"	\
	using 0:2:xtic(1) with lp title "NAT",	\
	"dat/trans-rate-graft-conc-".conc.".dat"	\
	using 0:2 with lp title "AF_GRAFT"
