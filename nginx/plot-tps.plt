set terminal pdfcairo enhanced color fontscale 1.1
set output "graph/graph-nginx-siege-tps-conc-".conc.".pdf"

set termoption noenhanced

set ylabel "Transaction rate (Ktps)"
set xlabel "File size (byte)"
set size ratio 0.4


plot	"dat/trans-rate-graft-conc-".conc.".dat"	\
	using 0:($2/1000):xtic(1) with lp title "GRAFT",	\
	"dat/trans-rate-nat-conc-".conc.".dat"	\
	using 0:($2/1000) with lp title "NAT"
