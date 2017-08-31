## nginx benchmarking using siege or ab

```shell-session
# at target host
$ cd graft-bench/nginx/docker/nginx-graft
$ docker build -t nginx-graft .
$ ../nginx-nat
$ docker build -t nginx-nat .
```

```shell-session
# generate test target file
$ cd graft-bench/nginx/docker/html
$ ./file-gen.sh
```

```shell-session
# run both nginx containers
# nginx-graft bind()s to 0.0.0.0:80 on host,
# nginx-nat bind()s to 0.0.0.0:8080 on host via port forward
$ cd graft-bench/nginx/docker
$ docker run -it --rm --cap-add=NET_ADMIN -v `pwd`/html:/var/www/html rnginx-graft 
$ docker run -it --rm -p 8080:8080 -v `pwd`/html:/var/www/html nginx-nat
```
