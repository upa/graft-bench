#!/bin/bash


docker_server=yayoi1
sshcmd="ssh -i ~/.ssh/id_rsa_nopass $docker_server"

eachlat=~/src/zeromq-4.2.2/perf/eachlat


# docker nat

msgcnt=10000

echo start mirror in nat conitaner at $docker_server

ipcmd="ip gr add zmq type ipv4 addr 10.0.0.1 port 5555"
perfcmd="mirror tcp://0.0.0.0:5555"
dockercmd="${ipcmd} && ${perfcmd}"

conid=`$sshcmd docker run -d --rm --cap-add=NET_ADMIN \
	graft-zmq bash -c \"${dockercmd}\"`

echo mirror container id is $conid

#for msgsize in 64 256 1000 4000 16000 64000 256000 1000000 4000000 16000000 64000000; do
#for msgsize in 64 128 256 512 1000 2000 4000 8000 16000 32000 64000 128000; do
for msgsize in 2000; do

	echo msgsize $msgsize

	echo start eachlat
	$eachlat tcp://10.0.0.1:5555 $msgsize $msgcnt \
	> output/graft-eachlat-msgsize_${msgsize}-msgcnt_${msgcnt}.txt

	sleep 1
	echo
done

echo stop container
$sshcmd docker stop $conid
