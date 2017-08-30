FROM ubuntu:latest

ARG workdir="/root"

# install required packages and usuful applications
RUN apt-get update && apt-get install -y \
	wget	\
	unzip	\
	autoconf	\
	g++		\
	gcc		\
	make		\
	net-tools	\
	bison		\
	flex



# setup sockperf
RUN cd ${workdir}	\
	&& wget https://github.com/Mellanox/sockperf/archive/sockperf_v2.zip \
	&& unzip sockperf_v2.zip	\
	&& cd sockperf-sockperf_v2/	\
	&& ./autogen.sh	\
	&& ./configure	\
	&& make		\
	&& make install
	
	
	
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
