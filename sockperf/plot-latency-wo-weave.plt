set terminal pdf enhanced color fontscale 1.2
set output "graph/graph-sockperf-".l4."-wo-weave.pdf"
set termoption noenhanced


set ylabel "latency (usec)"
set size ratio 1

set boxwidth 0.5
set style fill solid 0.5
set xrange [0:4]
set yrange [0:10]
set key top left
set ytics 1
#set xtics rotate by -30 offset first -0.2,1.5

plot	"dat/latency-".l4.".dat"	\
	every ::0::2 using ($0+1):2:3:4:(0.5):xtic(1)	\
	with boxerrorbars lc 1 notitle
