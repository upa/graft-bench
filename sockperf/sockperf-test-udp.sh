#!/bin/bash

image=graft-sockperf
nic=enp1s0
dst=10.0.0.2
src=10.0.0.1
weave_dst=10.32.1.2
weave_src=10.32.1.1
port=11111
outputdir=output
trynum=20
time=30


function docker_run() {

        cmd=$1
        shift
        options=$@

        ipgraft="ip gr add in type ipv4 addr ${src} port ${port}"
        ipgraft+=" && ip gr add out type ipv4 addr ${src} port dynamic"

        execcmd="${ipgraft} && $cmd"

        docker run --rm -it --cap-add=NET_ADMIN                      \
                -e GRAFT_CONV_PAIRS="0.0.0.0:${port}=in"        \
                -e GRAFT_BBCONN="out"                           \
                $options                                        \
                $image bash -c "${execcmd}" $output
}


#####################################################################
echo
echo Testing Graft. enable LRO on $nic
sudo ethtool -K $nic lro on

for x in `seq -w 1 $trynum`; do
        echo docker graft udp ping pong, $x
        docker_run "sockperf pp --time $time --msg-size 14 --ip $dst " \
                > $outputdir/docker_graft_host_pp_udp_"${x}".txt
done



#####################################################################
echo
echo Testing Docker NAT. disalbe LRO on $nic
sudo ethtool -K $nic lro off

for x in `seq -w 1 $trynum`; do
        echo docker nat udp ping pong, $x
        docker_run "sockperf pp --time $time --msg-size 14 --ip $dst " \
		"-e GRAFT=disable"	\
                > $outputdir/docker_nat_host_pp_udp_"${x}".txt
done

#####################################################################
echo
echo Testing weave. disalbe LRO on $nic
sudo ethtool -K $nic lro off

for x in `seq -w 1 $trynum`; do
        echo docker weave udp ping pong, $x
        docker_run "sockperf pp --time $time --msg-size 14 --ip ${weave_dst} " \
		"-e GRAFT=disable" "--net=weave" "--ip=${weave_src}"	\
                > $outputdir/docker_weave_docker_pp_udp_"${x}".txt
done

#####################################################################
echo
echo Testing Hosts. enable LRO on $nic
sudo ethtool -K $nic lro on

for x in `seq -w 1 $trynum`; do
        echo host udp ping pong, $x
        sockperf pp --time $time --msg-size 14 --ip $dst  \
                > $outputdir/host_none_host_pp_udp_${x}.txt
done



#####################################################################
echo
echo Testing Docker Container to Hosting Host via GRAFT

for x in `seq -w 1 $trynum`; do
        echo docker graft send to same host udp ping pong, $x
        docker_run "sockperf pp --time $time --msg-size 14 --ip $src " \
                > $outputdir/docker_graft_same-host_pp_udp_${x}.txt
done



#####################################################################
echo
echo Testing Docker Container to Hosting Host via NAT

for x in `seq -w 1 $trynum`; do
        echo docker graft send to same host udp ping pong, $x
        docker_run "sockperf pp --time $time --msg-size 14 --ip $src " \
		"-e GRAFT=disable"	\
                > $outputdir/docker_nat_same-host_pp_udp_${x}.txt
done


