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
RUN cd  ${workdir}      \
        && wget http://web.sfc.wide.ad.jp/~upa/zeromq-4.2.2-perf-mod.tar.gz \
        && tar zxvf zeromq-4.2.2-perf-mod.tar.gz        \
        && mv zeromq-4.2.2 zmq  \
        && cd zmq       \
        && ./autogen.sh \
        && ./configure  \
        && make -j 4

ENV PATH PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/zmq/perf

ENTRYPOINT []
