FROM ubuntu:latest

ARG workdir="/root"
ARG gopath="/root/go"

# install required packages and usuful applications
RUN apt-get update && apt-get install -y \
	wget	\
	unzip	\
	golang	\
	ca-certificates	\
	make		\
	git		\
	gcc		\
	bison		\
	flex		\
	net-tools


# setup gRPC bnechmark server and client to workdir
ENV GOPATH=/root/go
ADD grpc_bench_client	${workdir}/grpc_bench_client
ADD grpc_bench_server	${workdir}/grpc_bench_server
ADD key			${workdir}/key
RUN cd ${workdir}	\
	&& go get google.golang.org/grpc		\
	&& go build -o client grpc_bench_client/main.go	\
	&& go build -o server grpc_bench_server/main.go	

ENV PATH $PATH:${workdir}


# setup AF_GRAFT
RUN cd ${workdir}	\
	&& wget https://github.com/upa/af-graft/archive/master.zip	\
	&& unzip master.zip		\
	&& mv af-graft-master af-graft	\
	&& cd af-graft	\
	&& make		\
	&& make -C iproute2-4.10.0 install

ENV LD_PRELOAD ${workdir}/af-graft/tools/libgrwrap.so

ENTRYPOINT []
