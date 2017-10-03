#!/bin/sh
#
#
# start zookeeper at background  and start kafka at foreground

kafkadir=/root/kafka_2.11-0.11.0.1

echo
echo change ip address to 172.16.0.11
ip addr flush dev eth0
ip addr add 172.17.0.11/16 dev eth0
ip route add to default via 172.17.0.1

echo
echo set graft entries
ip gr add default-source type ipv4 addr 127.0.0.1 port dynamic 
ip gr add kafka type ipv4 addr 10.0.0.1 port 9092 
ip gr add zookeeper type ipv4 addr 127.0.0.1 port 2181 
ip gr show

echo
echo Conversion pairs is
env | grep GRAFT_CONV_PAIRS

echo
echo and execute kafka server
cd $kafkadir && \
	./bin/kafka-server-start.sh config/server.properties
