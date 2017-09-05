#!/bin/bash

# gather latencies
./parser.py Host	host_none_host_pp_tcp \
		> dat/latency-tcp.dat
./parser.py GRAFT	docker_graft_host_pp_tcp \
		>> dat/latency-tcp.dat
./parser.py NAT		docker_nat_host_pp_tcp	\
		>> dat/latency-tcp.dat
./parser.py Weave	docker_weave_docker_pp_tcp	\
		>> dat/latency-tcp.dat

./parser.py GRAFT	docker_graft_same-host_pp_tcp	\
		> dat/latency-tcp-lo.dat
./parser.py NAT		docker_nat_same-host_pp_tcp	\
		>> dat/latency-tcp-lo.dat

gnuplot plot-latency.plt
