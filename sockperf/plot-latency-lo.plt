set terminal pdf enhanced color fontscale 0.7
set output "graph/graph-sockperf-".l4."-lo.pdf"
set termoption noenhanced

set ylabel "latency (usec)"
set size ratio 1

set boxwidth 0.5
set style fill solid 0.5
set xrange [0:3]
set yrange [0:]
set key top left
#set xtics rotate by -30 offset first -0.2,1.5

plot	"dat/latency-".l4."-lo.dat"	\
	using ($0+1):2:3:4:(0.5):xtic(1)	\
	with boxerrorbars lc 1 notitle
