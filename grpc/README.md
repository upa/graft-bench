

```shell-session
$ sudo apt install golang
$ echo 'export GOPATH=$HOME/.go'
$ go get google.golang.org/grpc

$ cd graft-bench/grpc/docker/key
$ ./demo_key_gen.sh
$ cd ../
$ docker build -t graft-grpc .
```
