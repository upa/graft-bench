set terminal pdf enhanced color fontscale 1
set termoption noenhanced
set output "graph/graph-iperf3-multi-flow-".direct."-wo-weave.pdf"


set ylabel "Throughput (Gbps)"
set xlabel "Number of Flows"
set key bottom right

set yrange [0:]
set size ratio 0.4

plot	"dat/multi-flow_host_none_host_".direct.".dat"	\
	using 1:2 with lp title "Host",	\
	"dat/multi-flow_docker_graft_host_".direct.".dat"	\
	using 1:2 with lp title "GRAFT",	\
	"dat/multi-flow_docker_nat_host_".direct.".dat"	\
	using 1:2 with lp title "NAT"
