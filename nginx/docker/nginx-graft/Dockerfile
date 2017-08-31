FROM ubuntu:latest

ARG workdir="/root"

# install required packages and usuful applications
RUN apt-get update && apt-get install -y \
	git	\
	gcc	\
	make	\
	flex	\
	bison	\
	pkg-config	\
	wget	\
	unzip	\
	nginx	\
	&& rm -rf /etc/nginx/sites-enabled/default
ADD default /etc/nginx/sites-enabled/default

# setup AF_GRAFT
RUN cd ${workdir}       \
	&& wget https://github.com/upa/af-graft/archive/master.zip      \
	&& unzip master.zip             \
	&& mv af-graft-master af-graft  \
	&& cd af-graft  \
	&& make         \
	&& make -C iproute2-4.10.0 install

ENV LD_PRELOAD ${workdir}/af-graft/tools/libgrwrap.so
ENV GRAFT_CONV_PAIRS "0.0.0.0:80=nx4 :::80=nx6"

ENTRYPOINT []
CMD bash -c "ip gr add nx4 type ipv4 addr 0.0.0.0 port 80 && nginx -g 'daemon off;'"
