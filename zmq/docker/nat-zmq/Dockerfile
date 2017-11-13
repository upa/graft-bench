FROM ubuntu:latest

ARG workdir="/root"

RUN apt-get update && apt-get install -y \
	wget	\
	gcc	\
	g++	\
	make

# donwload and compile zmq
RUN cd  ${workdir}	\
	&& wget https://github.com/zeromq/libzmq/releases/download/v4.2.2/zeromq-4.2.2.tar.gz	\
	&& tar zxvf zeromq-4.2.2.tar.gz	\
	&& mv zeromq-4.2.2 zmq	\
	&& cd zmq	\
	&& ./configure	\
	&& make -j 4


ENV PATH PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/zmq/perf

ENTRYPOINT []
