



./parser-eachlat.py output/graft-eachlat-msgsize_*	> dat/graft-eachlat.dat
./parser-eachlat.py output/nat-eachlat-msgsize_*	> dat/nat-eachlat.dat

gnuplot plot-eachlat.plt
gnuplot plot-eachlat-low.plt
gnuplot plot-eachlat-high.plt



./parser-eachthr.py output/graft-eachthr-msgsize_*	> dat/graft-eachthr.dat
./parser-eachthr.py output/nat-eachthr-msgsize_*	> dat/nat-eachthr.dat

./parser-eachthr.py output/graft-eachthr-reverse-msgsize_*	\
						> dat/graft-eachthr-reverse.dat
./parser-eachthr.py output/nat-eachthr-reverse-msgsize_*	\
						> dat/nat-eachthr-reverse.dat


gnuplot -e "rev='-reverse'" plot-eachthr-bps.plt
gnuplot -e "rev='-reverse'" plot-eachthr-mps.plt
gnuplot -e "rev='-reverse'" plot-eachthr-mps-high.plt
