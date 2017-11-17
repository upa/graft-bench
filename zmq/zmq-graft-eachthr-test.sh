#!/bin/bash


docker_server=yayoi1
sshcmd="ssh -i ~/.ssh/id_rsa_nopass $docker_server"

eachthr=~/src/zeromq-4.2.2/perf/eachthr


duration=40

ipcmd="ip gr add zmq type ipv4 addr 10.0.0.1 port 5555"
perfcmd="mirror_thr tcp://0.0.0.0:5555"
dockercmd="${ipcmd} && ${perfcmd}"


for msgsize in 64 256 1000 4000 16000 64000 256000 1000000 4000000 16000000 64000000; do

	out="output/graft-eachthr-msgsize_${msgsize}.txt"

	echo msgsize $msgsize, output $out

	echo start mirror_thr at $docker_server
	$sshcmd docker run -i --rm --cap-add=NET_ADMIN \
	graft-zmq bash -c \"${dockercmd}\" > $out &

	echo start eachthr
	$eachthr tcp://10.0.0.1:5555 $msgsize $duration

	echo done sleep 5sec
	echo
	sleep 5
done

