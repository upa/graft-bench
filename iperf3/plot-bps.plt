set terminal pdfcairo enhanced color fontscale 1
set output "graph/graph-iperf3-1flow-".direct.".pdf"
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
set ylabel "Throughput (bps)"
set size ratio 0.6

set boxwidth 0.5
set style fill solid 0.5
set xrange [0:7]
set yrange [0:]
set key top left
#set xtics rotate by -30 offset first -0.2,1.5

plot	"dat/single-flow-".direct.".dat"	\
	using ($0+1):2:3:4:(0.5):xtic(1)	\
	with boxerrorbars lw 3 lc 1 title "Inter-Hosts",	\
	"dat/single-flow-".direct."-lo.dat"	\
	using ($0+5):2:3:4:(0.5):xtic(1)	\
	with boxerrorbars lw 3 lc 2 title "Loopback"

