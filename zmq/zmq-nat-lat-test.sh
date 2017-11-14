#!/bin/bash


docker_server=yayoi1
sshcmd="ssh -i ~/.ssh/id_rsa_nopass $docker_server"

local_lat=~/src/zeromq-4.2.2/perf/local_lat
remote_lat=~/src/zeromq-4.2.2/perf/remote_lat


# docker nat

msgcnt=10000

for x in `seq 1 10`; do
for msgsize in 64 256 1000 4000 16000 64000 256000 1000000 4000000 16000000 64000000; do

	echo msgsize $msgsize, count $x
	echo start local_lat in nat conitaner at $docker_server

	conid=`$sshcmd docker run -d --rm -p 10.0.0.1:5555:5555 nat-zmq \
	local_lat tcp://0.0.0.0:5555 $msgsize $msgcnt`
	echo $conid

	echo start remote_lat
	$remote_lat tcp://10.0.0.1:5555 $msgsize $msgcnt \
	> output/nat-lat-msgsize_${msgsize}-msgcnt_${msgcnt}-${x}.txt

	echo stop container
	$sshcmd docker stop $conid
	sleep 2
done
done
