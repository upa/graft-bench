#!/bin/bash

# gather latencies
./parser.py Host	host_none_host_pp_tcp \
		> dat/latency-tcp.dat
./parser.py GRAFT	docker_graft_host_pp_tcp \
		>> dat/latency-tcp.dat
./parser.py NAT		docker_nat_host_pp_tcp	\
		>> dat/latency-tcp.dat
./parser.py VXLAN	docker_weave_docker_pp_tcp	\
		>> dat/latency-tcp.dat

./parser.py GRAFT	docker_graft_same-host_pp_tcp	\
		> dat/latency-tcp-lo.dat
./parser.py NAT		docker_nat_same-host_pp_tcp	\
		>> dat/latency-tcp-lo.dat


./parser.py Host	host_none_host_pp_udp \
		> dat/latency-udp.dat
./parser.py GRAFT	docker_graft_host_pp_udp \
		>> dat/latency-udp.dat
./parser.py NAT		docker_nat_host_pp_udp	\
		>> dat/latency-udp.dat
./parser.py VXLAN	docker_weave_docker_pp_udp	\
		>> dat/latency-udp.dat

./parser.py GRAFT	docker_graft_same-host_pp_udp	\
		> dat/latency-udp-lo.dat
./parser.py NAT		docker_nat_same-host_pp_udp	\
		>> dat/latency-udp-lo.dat

gnuplot -e "l4='tcp'" plot-latency.plt
gnuplot -e "l4='udp'" plot-latency.plt
gnuplot -e "l4='tcp'" plot-latency-wo-weave.plt
gnuplot -e "l4='udp'" plot-latency-wo-weave.plt
gnuplot -e "l4='tcp'" plot-latency-lo.plt
gnuplot -e "l4='udp'" plot-latency-lo.plt
gnuplot -e "l4='tcp'" plot-latency-current.plt
gnuplot -e "l4='udp'" plot-latency-current.plt

gnuplot -e "l4='tcp'" plot-latency-current-wo-weave.plt
gnuplot -e "l4='udp'" plot-latency-current-wo-weave.plt
