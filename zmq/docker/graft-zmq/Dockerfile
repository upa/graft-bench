FROM ubuntu:latest

ARG workdir="/root"

RUN apt-get update && apt-get install -y \
	wget	\
	gcc	\
	g++	\
	make	\
	pkg-config	\
	flex	\
	bison	\
	unzip	\
	autoconf	\
	automake	\
	libtool

# donwload and compile zmq
ADD zeromq-4.2.2 ${workdir}/zeromq-4.2.2
RUN cd  ${workdir}	\
	&& mv zeromq-4.2.2 zmq	\
	&& cd zmq	\
	&& ./autogen.sh	\
	&& ./configure	\
	&& make -j 4


ENV PATH PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/zmq/perf


# setup AF_GRAFT
RUN cd ${workdir}       \
        && wget https://github.com/upa/af-graft/archive/master.zip      \
        && unzip master.zip             \
        && mv af-graft-master af-graft  \
        && cd af-graft  \
        && make         \
        && make -C iproute2-4.10.0 install

ENV LD_PRELOAD ${workdir}/af-graft/tools/libgrwrap.so
ENV GRAFT_CONV_PAIRS "0.0.0.0:5555=zmq"

ENTRYPOINT []

