#!/bin/bash

image=graft-iperf3
nic=enp1s0
src=10.0.0.1
port=5201
outputdir=output
trynum=20
duration=15

function docker_run() {

        cmd=$1
        shift
        options=$@

        ipgraft="ip gr add default-source type ipv4 addr ${src}"
        ipgraft+=" && ip gr add in type ipv4 addr ${src} port ${port}"

        execcmd="${ipgraft} && $cmd"

        echo docker run --rm -it --cap-add=NET_ADMIN            \
                $options                                        \
                $image bash -c "${execcmd}"  >&2

        docker run --rm -it --cap-add=NET_ADMIN                 \
                $options                                        \
                $image bash -c "${execcmd}"
}

for pktsize in 64 128 512 1024 1500; do

for x in `seq -w 1 $trynum`; do

	echo docker graft udp c2c test seq $x
	docker_run "iperf3 -c 127.0.0.1 -u -b 0 -l $pktsize -O 5 -t $duration -J"	\
		> $outputdir/docker_graft_c2c-udp_pktsize-${pktsize}_${x}.txt

done

done

