#!/bin/bash

target_graft=10.0.0.2:80
target_nat=10.0.0.2:8080
outputdir=output
trynum=20

conn=50
reqnum=100000
time=30s

<<OUT
for s in 64 256 1k 4k 16k 64k 256k 1m 4m 16m 64m; do
for x in `seq -w 1 $trynum`; do
	
	echo $s byte, target graft, count $x
	echo \
	siege -b -c $conn -t $time http://$target_graft/${s}byte.img \
		--log=$outputdir/graft_siege_conc-${conn}_${s}.txt
	siege -b -c $conn -t $time http://$target_graft/${s}byte.img \
		--log=$outputdir/graft_siege_conc-${conn}_${s}.txt
	# wait for TIME_WAIT disappear
	sleep 70
done
done
OUT

for conn in 1 50; do
for s in 64 256 1k 4k 16k 64k 256k 1m 4m 16m 64m; do
for x in `seq -w 1 $trynum`; do
	
	echo $s byte, target nat, count $x
	echo \
	siege -b -c $conn -t $time http://$target_nat/${s}byte.img \
		--log=$outputdir/nat_siege_conc-${conn}_${s}.txt
	siege -b -c $conn -t $time http://$target_nat/${s}byte.img \
		--log=$outputdir/nat_siege_conc-${conn}_${s}.txt
	# wait for TIME_WAIT disappear
	sleep 70
done
done
done
