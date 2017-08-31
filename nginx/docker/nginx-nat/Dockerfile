FROM ubuntu:latest

ARG workdir="/root"

# install required packages and usuful applications
RUN apt-get update && apt-get install -y \
	nginx	\
	&& rm -rf /etc/nginx/sites-enabled/default
ADD default /etc/nginx/sites-enabled/default


# expose port 8080 to docker0 port forward
EXPOSE 80
EXPOSE 8080

ENTRYPOINT []

CMD ["nginx", "-g", "daemon off;"]
