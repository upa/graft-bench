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

EXPOSE 9092

ENTRYPOINT []
CMD bash -c "cd /root/kafka_2.11-0.11.0.1 && ./bin/kafka-server-start.sh config/server.properties"
