set terminal pdf enhanced color fontscale 0.7
set output "graph/graph-sockperf-".l4.".pdf"
set termoption noenhanced


set ylabel "latency (usec)"
set size ratio 0.6

set boxwidth 0.5
set style fill solid 0.5
set xrange [0:5]
set yrange [0:]
set key top left
#set xtics rotate by -30 offset first -0.2,1.5

plot	"dat/latency-".l4.".dat"	\
	using ($0+1):2:3:4:(0.5):xtic(1)	\
	with boxerrorbars lc 1 notitle
