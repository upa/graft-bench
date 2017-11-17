



./parser-eachlat.py output/graft-eachlat-msgsize_*	> dat/graft-eachlat.dat
./parser-eachlat.py output/nat-eachlat-msgsize_*	> dat/nat-eachlat.dat

gnuplot plot-eachlat-low.plt
gnuplot plot-eachlat-high.plt



./parser-eachthr.py output/graft-eachthr-msgsize_*	> dat/graft-eachthr.dat
./parser-eachthr.py output/nat-eachthr-msgsize_*	> dat/nat-eachthr.dat
