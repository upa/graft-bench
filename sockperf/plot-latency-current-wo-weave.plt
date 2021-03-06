set terminal pdf enhanced color fontscale 1.2
set output "graph/graph-sockperf-".l4."-current-wo-weave.pdf"
set termoption noenhanced


set ylabel "latency (usec)"
set size square

set boxwidth 0.5
set style fill solid 0.5
set xrange [0:3]
set yrange [0:]
set key top left
#set xtics rotate by -30 offset first -0.2,1.5

plot	"dat/latency-".l4.".dat"	\
	every ::0::0 using ($0+1):2:3:4:(0.5):xtic("Host")	\
	with boxerrorbars lt 1 notitle,	\
	"dat/latency-".l4.".dat"	\
	every ::2::2 using ($0+2):2:3:4:(0.5):xtic("Container")	\
	with boxerrorbars lt 1 notitle,	\
