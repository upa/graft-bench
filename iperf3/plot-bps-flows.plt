set terminal pdfcairo enhanced color fontscale 1
set termoption noenhanced
set output "graph/graph-iperf3-multi-flow-".direct.".pdf"

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
set ylabel "Throughput (Gbps)"
set xlabel "Number of Flows"
set key bottom right

set yrange [0:]

plot	"dat/multi-flow_host_none_host_".direct.".dat"	\
	using 1:2 with lp lc 1 lw 4 title "Host",	\
	"dat/multi-flow_docker_graft_host_".direct.".dat"	\
	using 1:2 with lp lc 2 lw 4 title "GRAFT",	\
	"dat/multi-flow_docker_nat_host_".direct.".dat"	\
	using 1:2 with lp lc 3 lw 4 title "NAT"
