## sockperf test for TCP latency

### Test patterns
- Between Container and Host through a physical link
    - via AF_GRAFT
    - via Docker NAT (docker0)

- Between Host and Host through a physical link
    - via normal linux network stack

- Between Contaner and Host through a loopback interface
    - via AF_GRAFT
    - via Docker NAT (docker0)


### How to start test

First, execut sockperf server `sockperf sr --tcp` on both hosts and
`$ docker run -it --rm --net=weave --ip=10.32.1.2 -e GRAFT=disable graft-sockperf sockperf sr --tcp`

```shell-session
$ cd graft-bench/sockperf
$ cd docker
$ docker build -t graft-sockperf
$ vim sockperf-test.sh # edit parameters such as ip addrs
$ sudo ./sockperf-test.sh
```
