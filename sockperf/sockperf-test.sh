#!/bin/bash

image=graft-sockperf
nic=enp1s0
dst=10.0.0.2
src=10.0.0.1
port=11111
outputdir=output
trynum=1
time=4


function docker_run() {

        cmd=$1
        shift
        options=$@

        ipgraft="ip gr add in type ipv4 addr ${src} port ${port}"
        ipgraft+=" && ip gr add out type ipv4 addr ${src} port dynamic"

        execcmd="${ipgraft} && $cmd"

        docker run -it --cap-add=NET_ADMIN                      \
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
        echo docker graft tcp ping pong, $x
        docker_run "sockperf pp --time $time --msg-size 14 --ip $dst --tcp" \
                > $outputdir/docker_graft_host_pp_tcp_"${x}".txt
done



#####################################################################
echo
echo Testing Docker NAT. disalbe LRO on $nic
sudo ethtool -K $nic lro off

for x in `seq -w 1 $trynum`; do
        echo docker nat tcp ping pong, $x
        docker_run "sockperf pp --time $time --msg-size 14 --ip $dst --tcp" \
		"-e GRAFT=disable"	\
                > $outputdir/docker_nat_host_pp_tcp_"${x}".txt
done



#####################################################################
echo
echo Testing Hosts. enable LRO on $nic
sudo ethtool -K $nic lro on

for x in `seq -w 1 $trynum`; do
        echo host tcp ping pong, $x
        sockperf pp --time $time --msg-size 14 --ip $dst --tcp \
                > $outputdir/host_none_host_pp_tcp_${x}.txt
done



#####################################################################
echo
echo Testing Docker Container to Hosting Host via GRAFT

for x in `seq -w 1 $trynum`; do
        echo docker graft send to same host tcp ping pong, $x
        docker_run "sockperf pp --time $time --msg-size 14 --ip $src --tcp" \
                > $outputdir/docker_graft_same-host_pp_tcp_${x}.txt
done



#####################################################################
echo
echo Testing Docker Container to Hosting Host via NAT

for x in `seq -w 1 $trynum`; do
        echo docker graft send to same host tcp ping pong, $x
        docker_run "sockperf pp --time $time --msg-size 14 --ip $src --tcp" \
		"-e GRAFT=disable"	\
                > $outputdir/docker_nat_same-host_pp_tcp_${x}.txt
done


