#!/bin/bash


# gather 1 flow results
./parser.py Host	host_none_host_send_parallel-01 \
		> dat/single-flow-send.dat
./parser.py GRAFT	docker_graft_host_send_parallel-01 \
		>> dat/single-flow-send.dat
./parser.py NAT		docker_nat_host_send_parallel-01 \
		>> dat/single-flow-send.dat
./parser.py VXLAN	docker_weave_docker_send_parallel-01 \
		>> dat/single-flow-send.dat


./parser.py GRAFT	docker_graft_same-host_send_parallel-01 \
		> dat/single-flow-send-lo.dat
./parser.py Bridge	docker_nat_same-host_send_parallel-01 \
		>> dat/single-flow-send-lo.dat


# gather 1 flow results
./parser.py Host	host_none_host_recv_parallel-01 \
		> dat/single-flow-recv.dat
./parser.py GRAFT	docker_graft_host_recv_parallel-01 \
		>> dat/single-flow-recv.dat
./parser.py NAT		docker_nat_host_recv_parallel-01 \
		>> dat/single-flow-recv.dat
./parser.py VXLAN	docker_weave_docker_recv_parallel-01 \
		>> dat/single-flow-recv.dat


./parser.py GRAFT	docker_graft_same-host_recv_parallel-01 \
		> dat/single-flow-recv-lo.dat
./parser.py Bridge	docker_nat_same-host_recv_parallel-01 \
		>> dat/single-flow-recv-lo.dat

./parser.py GRAFT	docker_graft_graft-docker_recv_parallel-01 \
		> dat/single-flow-recv-c2c.dat
./parser.py Bridge	docker_bridge_docker_recv_parallel \
		>> dat/single-flow-recv-c2c.dat

./parser.py GRAFT	docker_graft_graft-docker_send_parallel-01 \
		> dat/single-flow-send-c2c.dat
./parser.py Bridge	docker_bridge_l2_docker_send_parallel \
		>> dat/single-flow-send-c2c.dat



gnuplot -e "direct='send'" plot-bps.plt
gnuplot -e "direct='recv'" plot-bps.plt
gnuplot -e "direct='send'" plot-bps-wo-weave.plt
gnuplot -e "direct='recv'" plot-bps-wo-weave.plt
gnuplot -e "direct='send'" plot-bps-lo.plt
gnuplot -e "direct='recv'" plot-bps-lo.plt
gnuplot -e "direct='send'" plot-bps-current.plt
gnuplot -e "direct='recv'" plot-bps-current.plt
gnuplot -e "direct='send'" plot-bps-current-wo-weave.plt
gnuplot -e "direct='recv'" plot-bps-current-wo-weave.plt
gnuplot -e "direct='send'" plot-bps-c2c-tcp.plt
gnuplot -e "direct='recv'" plot-bps-c2c-tcp.plt

# gater multiple flows results
for scheme in \
	host_none_host docker_graft_host \
	docker_nat_host docker_weave_docker; do
for direct in send recv; do
	of=dat/multi-flow_${scheme}_${direct}.dat
	rm $of
	touch $of
for para in 01 02 04 06 08 10 12 14 16 18 20; do
	./parser.py $para ${scheme}_${direct}_parallel-${para} \
		>> $of
done
done
done

gnuplot -e "direct='send'" plot-bps-flows.plt
gnuplot -e "direct='recv'" plot-bps-flows.plt
gnuplot -e "direct='send'" plot-bps-flows-wo-weave.plt
gnuplot -e "direct='recv'" plot-bps-flows-wo-weave.plt

gnuplot -e "direct='send'" plot-bps-c2c.plt
gnuplot -e "direct='recv'" plot-bps-c2c.plt

./parser-udp.py 64 docker_graft_c2c-udp_pktsize-64 > dat/c2c-udp-graft.txt
./parser-udp.py 128 docker_graft_c2c-udp_pktsize-128 >> dat/c2c-udp-graft.txt
./parser-udp.py 256 docker_graft_c2c-udp_pktsize-256 >> dat/c2c-udp-graft.txt
./parser-udp.py 512 docker_graft_c2c-udp_pktsize-512 >> dat/c2c-udp-graft.txt
./parser-udp.py 1024 docker_graft_c2c-udp_pktsize-1024 >> dat/c2c-udp-graft.txt
./parser-udp.py 1500 docker_graft_c2c-udp_pktsize-1500 >> dat/c2c-udp-graft.txt

./parser-udp.py 64 docker_bridge_c2c-udp_pktsize-64 > dat/c2c-udp-bridge.txt
./parser-udp.py 128 docker_bridge_c2c-udp_pktsize-128 >> dat/c2c-udp-bridge.txt
./parser-udp.py 256 docker_bridge_c2c-udp_pktsize-256 >> dat/c2c-udp-bridge.txt
./parser-udp.py 512 docker_bridge_c2c-udp_pktsize-512 >> dat/c2c-udp-bridge.txt
./parser-udp.py 1024 docker_bridge_c2c-udp_pktsize-1024 >> dat/c2c-udp-bridge.txt
./parser-udp.py 1500 docker_bridge_c2c-udp_pktsize-1500 >> dat/c2c-udp-bridge.txt

gnuplot plot-bps-c2c-udp.plt
