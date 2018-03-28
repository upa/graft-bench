



./parser-eachlat.py output/graft-eachlat-msgsize_*	> dat/graft-eachlat.dat
./parser-eachlat.py output/nat-eachlat-msgsize_*	> dat/nat-eachlat.dat

gnuplot plot-eachlat.plt
gnuplot plot-eachlat-low.plt
gnuplot plot-eachlat-high.plt

gnuplot plot-eachlat-256.plt
gnuplot plot-eachlat-rate-256.plt



./parser-eachthr.py output/graft-eachthr-msgsize_*	> dat/graft-eachthr.dat
./parser-eachthr.py output/nat-eachthr-msgsize_*	> dat/nat-eachthr.dat

./parser-eachthr.py output/graft-eachthr-reverse-msgsize_*	\
						> dat/graft-eachthr-reverse.dat
./parser-eachthr.py output/nat-eachthr-reverse-msgsize_*	\
						> dat/nat-eachthr-reverse.dat

./parser-lat-rate.py dat/nat-eachlat.dat dat/graft-eachlat.dat \
	> dat/eachlat-reduce-rate.dat


gnuplot -e "rev='-reverse'" plot-eachthr-bps.plt
gnuplot -e "rev='-reverse'" plot-eachthr-mps.plt
gnuplot -e "rev='-reverse'" plot-eachthr-mps-high.plt

gnuplot -e "rev='-reverse'" plot-eachthr-bps-256.plt
gnuplot -e "rev='-reverse'" plot-eachthr-mps-256.plt
gnuplot -e "rev=''" plot-eachthr-bps-256.plt
gnuplot -e "rev=''" plot-eachthr-mps-256.plt
