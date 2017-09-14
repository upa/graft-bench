FROM ubuntu:latest

ARG workdir="/root"

# install required packages and usuful applications
RUN apt-get update && apt-get install -y \
	gcc	\
	make	\
	flex	\
	bison	\
	pkg-config	\
	wget	\
	unzip	\
	openjdk-8-jre

# install kafka
RUN cd ${workdir}	\
	&& wget http://ftp.jaist.ac.jp/pub/apache/kafka/0.11.0.1/kafka_2.11-0.11.0.1.tgz \
	&& tar zxvf kafka_2.11-0.11.0.1.tgz

ADD server.properties ${workdir}/kafka_2.11-0.11.0.1/config/server.properties
ADD start.sh ${workdir}/start.sh

# setup AF_GRAFT
RUN cd ${workdir}       \
	&& wget https://github.com/upa/af-graft/archive/master.zip      \
	&& unzip master.zip             \
	&& mv af-graft-master af-graft  \
	&& cd af-graft  \
	&& make         \
	&& make -C iproute2-4.10.0 install

ENV LD_PRELOAD ${workdir}/af-graft/tools/libgrwrap.so
ENV GRAFT_CONV_PAIRS="0.0.0.0:9092=kafka 172.17.0.11:9092=kafka 127.0.0.1:2181=zookeeper 0.0.0.0:0=default-source"

ENTRYPOINT []
CMD bash /root/start.sh
