set terminal pdf enhanced color fontscale 1
set output "graph/graph-iperf3-1flow-".direct."-lo.pdf"
set termoption noenhanced


set grid ytic
set ylabel "Throughput (Gbps)"
set size ratio 1

set boxwidth 0.5
set style fill solid 0.5
set xrange [0:3]
set yrange [0:]
set key top left
#set xtics rotate by -30 offset first -0.2,1.5

plot	"dat/single-flow-".direct."-lo.dat"	\
	using ($0+1):2:3:4:(0.5):xtic(1)	\
	with boxerrorbars lc 1 notitle
