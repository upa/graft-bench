

### Kafka broker with AF_GRAFT in docker

This dockerfile is really specialzed for my benchmarking.

To execute this kakfa container, af_graft.ko must be installed into a
host, the host must have IP address '10.0.0.1' (the kafka on a
container uses this IP address), and zookeeper must run on the host
and listen on 127.0.0.1 or 0.0.0.0.

And, the kafka container uses '172.17.0.11/16' on docker0 network.
This IP address is internally configured (because docker0 prohibits
users from chaning IP address of containers through --ip option).


1. run zookeeper on the host: `./bin/zookeeper-server-start.sh config/zookeeper.properties`, zookeeper.properties is default from the source.
2. check the host has ip address 10.0.0.1.
3. run the kafka container: `docker run -it --rm --cap-add=NET_ADMIN graft-kafka`
Then, the kafka broker process listens on 10.0.0.1:9092 on the host.

To change the IP address '10.0.0.1', edit `advertised.host.name`
in server.properties, edit the GRAFT end point named `kafka` in start.sh
(and rebuild docker image).
