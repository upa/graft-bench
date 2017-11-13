set terminal pdfcairo enhanced color fontscale 0.9
set output "graph/graph-nginx-siege-tps-conc-".conc.".pdf"

set termoption noenhanced

set linetype 1 lc rgb "#009e73" lw 1
set linetype 2 lc rgb "#56b4e9" lw 1
set linetype 3 lc rgb "#e69f00" lw 1
set linetype 4 lc rgb "#f0e442" lw 1
set linetype 5 lc rgb "#0072b2" lw 1
set linetype 6 lc rgb "#e54e40" lw 1
set linetype 7 lc rgb "black"   lw 1
set linetype 8 lc rgb "gray50"  lw 1
set linetype 9 lc rgb "dark-violet" lw 1
set linetype cycle  9

set grid ytic
set ylabel "Transactions per second"
set xlabel "File size (byte)"
set size ratio 0.8

plot	"dat/trans-rate-nat-conc-".conc.".dat"	\
	using ($0):2:xtic(1) with lp lc 1 lw 4 title "docker NAT",	\
	"dat/trans-rate-graft-conc-".conc.".dat"	\
	using ($0):2 with lp lc 2 lw 4 title "AF_GRAFT"
