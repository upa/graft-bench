FROM ubuntu:latest

ARG workdir="/root"

RUN apt-get update && apt-get install -y \
	wget	\
	gcc	\
	g++	\
	make	\
        autoconf        \
        automake        \
        libtool

# donwload and compile zmq
ADD zeromq-4.2.2 ${workdir}/zeromq-4.2.2
RUN cd  ${workdir}      \
        && mv zeromq-4.2.2 zmq  \
        && cd zmq       \
        && ./autogen.sh \
        && ./configure  \
        && make -j 4

ENV PATH PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/zmq/perf

ENTRYPOINT []
