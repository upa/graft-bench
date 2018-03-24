#!/bin/bash

image=graft-iperf3
nic=enp1s0
dst="10.0.0.2"
src=10.0.0.1
weave_dst="10.32.1.2"
weave_src="10.32.1.1"
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

	echo docker run --rm -it --cap-add=NET_ADMIN		\
		$options					\
		$image bash -c "${execcmd}"  >&2

	docker run --rm -it --cap-add=NET_ADMIN			\
		$options					\
		$image bash -c "${execcmd}"
}



#for p in 01 02 04 06 08 10 12 14 16 18 20; do
for p in 01; do

<<COMMENTOUT1
#####################################################################
echo
echo Testing Graft. enable LRO on $nic
sudo ethtool -K $nic lro on

for x in `seq -w 1 $trynum`; do
	echo docker graft send test parallel "${p}", $x
	docker_run "iperf3 -c graft:$dst -O 5 -t $duration -P ${p} -J" \
		> $outputdir/docker_graft_host_send_parallel-"${p}"_"${x}".txt
done


for x in `seq -w 1 $trynum`; do
	echo docker graft recv test parallel "${p}", $x
	docker_run "iperf3 -c graft:$dst -O 5 -t $duration -P ${p} -R -J" \
		> $outputdir/docker_graft_host_recv_parallel-"${p}"_"${x}".txt
done


#####################################################################
echo
echo Testing Docker NAT. disalbe LRO on $nic
sudo ethtool -K $nic lro off

for x in `seq -w 1 $trynum`; do
	echo docker nat send test parallel "${p}", $x
	docker_run "iperf3 -c $dst -O 5 -t $duration -P ${p} -J" "-e GRAFT=disable" \
		> $outputdir/docker_nat_host_send_parallel-"${p}"_"${x}".txt
done


for x in `seq -w 1 $trynum`; do
	echo docker nat recv test parallel "${p}", $x
	docker_run "iperf3 -c $dst -O 5 -t $duration -P ${p} -R -J" "-e GRAFT=disable" \
		> $outputdir/docker_nat_host_recv_parallel-"${p}"_"${x}".txt
done

#####################################################################
echo
echo Testing Weave. disable LRO $nic
sudo ethtool -K $nic lro off

for x in `seq -w 1 $trynum`; do
	echo docker weave send test parallel "${p}", $x
	docker_run "iperf3 -c ${weave_dst} -O 5 -t $duration -P ${p} -J" \
		"-e GRAFT=disable" "--net=weave" "--ip=${weave_src}"	\
		> $outputdir/docker_weave_docker_send_parallel-"${p}"_"${x}".txt
done


for x in `seq -w 1 $trynum`; do
	echo docker weave recv test parallel "${p}", $x
	docker_run "iperf3 -c ${weave_dst} -O 5 -t $duration -P ${p} -R -J" \
		"-e GRAFT=disable" "--net=weave" "--ip=${weave_src}"	\
		> $outputdir/docker_weave_docker_recv_parallel-"${p}"_"${x}".txt
done

#####################################################################
echo
echo Testing Host. enable LRO on $nic
sudo ethtool -K $nic lro on

for x in `seq -w 1 $trynum`; do
	echo host send test parrallel "${p}", $x
	iperf3 -c $dst -O 5 -t $duration -P ${p} -J \
		> $outputdir/host_none_host_send_parallel-"${p}"_"${x}".txt
done


for x in `seq -w 1 $trynum`; do
	echo host recv test parrallel "${p}", $x
	iperf3 -c $dst -O 5 -t $duration -P ${p} -J \
		> $outputdir/host_none_host_recv_parallel-"${p}"_"${x}".txt
done


#####################################################################
echo
echo Testing Docker Container to Hosting Host via GRAFT

for x in `seq -w 1 $trynum`; do
	echo docker graft send to same host test parallel "${p}", $x
	docker_run "iperf3 -c graft:$src -O 5 -t $duration -P ${p} -J" \
		> $outputdir/docker_graft_same-host_send_parallel-"${p}"_"${x}".txt
done

for x in `seq -w 1 $trynum`; do
	echo docker nat recv from same host test parallel "${p}", $x
	docker_run "iperf3 -c graft:$src -O 5 -t $duration -P ${p} -R -J" \
		> $outputdir/docker_graft_same-host_recv_parallel-"${p}"_"${x}".txt
done


#####################################################################
echo
echo Testing Docker Container to Hosting Host via NAT

for x in `seq -w 1 $trynum`; do
	echo docker nat send to same host test parallel "${p}", $x
	docker_run "iperf3 -c $src -O 5 -t $duration -P ${p} -J" "-e GRAFT=disable" \
		> $outputdir/docker_nat_same-host_send_parallel-"${p}"_"${x}".txt
done

for x in `seq -w 1 $trynum`; do
	echo docker nat recv from same host test parallel "${p}", $x
	docker_run "iperf3 -c $src -O 5 -t $duration -P ${p} -R -J" "-e GRAFT=disable" \
		> $outputdir/docker_nat_same-host_recv_parallel-"${p}"_"${x}".txt
done




#####################################################################
echo
echo Testing Docker Container to Container via GRAFT

for x in `seq -w 1 $trynum`; do
	echo docker graft send to graft conintaer test parallel "${p}", $x
	docker_run "iperf3 -c graft:$src -O 5 -t $duration -P ${p} -J" \
		> $outputdir/docker_graft_graft-docker_send_parallel-"${p}"_"${x}".txt
done

for x in `seq -w 1 $trynum`; do
	echo docker nat recv from same host test parallel "${p}", $x
	docker_run "iperf3 -c graft:$src -O 5 -t $duration -P ${p} -R -J" \
		> $outputdir/docker_graft_graft-docker_recv_parallel-"${p}"_"${x}".txt
done

COMMENTOUT1

#####################################################################
echo
echo Testing Docker Container to Docker Container via Brdige

for x in `seq -w 1 $trynum`; do
	echo docker brdige send to same host docker test parallel "${p}", $x
	docker_run "iperf3 -c $src -O 5 -t $duration -P ${p} -J" "-e GRAFT=disable" \
		> $outputdir/docker_bridge_docker_send_parallel-"${p}"_"${x}".txt
done

for x in `seq -w 1 $trynum`; do
	echo docker bridge recv from same host container test parallel "${p}", $x
	docker_run "iperf3 -c $src -O 5 -t $duration -P ${p} -R -J" "-e GRAFT=disable" \
		> $outputdir/docker_bridge_docker_recv_parallel-"${p}"_"${x}".txt
done


done


