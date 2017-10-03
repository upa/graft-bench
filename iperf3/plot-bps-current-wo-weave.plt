set terminal pdf enhanced color fontscale 2.4
set output "graph/graph-iperf3-1flow-".direct."-current-wo-weave.pdf"
#set termoption noenhanced

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

set grid ytic dt (10,5) lw 2
set ylabel "Throughput (Gbps)"
#set size ratio 1
set size square

set boxwidth 0.5
set style fill solid 0.5
set xrange [0:3]
set yrange [0:]
set key top left
#set xtics rotate by -30 offset first -0.2,1.5


plot	"dat/single-flow-".direct.".dat"	\
	every ::0::0 using ($0+1):2:3:4:(0.5):xtic(1)	\
	with boxerrorbars lw 8 lc 1 notitle,	\
	"dat/single-flow-".direct.".dat"	\
	every ::2::2 using ($0+2):2:3:4:(0.5):xtic(1)	\
	with boxerrorbars lw 8 lc 1 notitle

