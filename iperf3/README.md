## iperf3 test for TCP throughput

### Test patterns
- From/To Docker Container To/From Host through a physical link
    - via AF_GRAFT
    - via Docker NAT (docker0)

- From Host to Host through a physical link
    - via normal linux network stack

- From/To Docker Container To/From Host through a loopback interface
    - via AF_GRAFT
    - via Docker NAT (docker0)


### How to start test

First, execut iperf3 server `iperf3 -s` on both hosts.

```shell-session
$ cd graft-bench/iperf3
$ cd docker
$ docker build -t graft-iperf3
$ vim iperf3-test.sh # edit parameters such as ip addrs
$ sudo ./iperf3-test.sh
```
