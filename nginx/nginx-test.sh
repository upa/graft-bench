#!/bin/bash

target_graft=10.0.0.2:80
target_nat=10.0.0.2:8080
outputdir=output
trynum=20

conn=1
reqnum=100000

for s in 64 256 1k 4k 16k 64k 256k 1m 4m 16m 64m; do
for x in `seq -w 1 $trynum`; do
	
	echo $s byte, target graft, count $x
	ab -n $reqnum -c $conn http://$target_graft/${s}.img \
		> $outputdir/graft_ab_${s}_${x}.txt
	# wait for TIME_WAIT disappear
	sleep 120
done
done

<<OUT
for s in 64 256 1k 4k 16k 64k 256k 1m 4m 16m 64m; do
for x in `seq -w 1 $trynum`; do

	echo $s byte, target nat, count $x
	siege -b -c $conc -t $conc http://$target_nat/${s}.img \
		--log=$outputdir/nat_siege_${s}_${x}.txt
	sleep 70
done
done
OUT
