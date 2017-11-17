/*
 * zeromq message mirror for benchmarking.
 */


#include "../include/zmq.h"
#include <stdio.h>
#include <stdlib.h>


int main(int argc, char **argv)
{
	const char *bind_to;
	void *ctx;
	void *s;
	int rc;
	zmq_msg_t msg;

	if (argc != 2) {
		printf("usage: mirror <bind-to>\n");
		return 1;
	}

	bind_to = argv[1];

	ctx = zmq_init(1);

	if (!ctx) {
		printf("error in zmq_init: %s\n", zmq_strerror(errno));
		return -1;
	}

	s = zmq_socket(ctx, ZMQ_REP);
	if (!s) {
		printf("error in zmq_socket: %s\n", zmq_strerror(errno));
		return -1;
	}

	rc = zmq_bind(s, bind_to);
	if (rc != 0) {
		printf("error in zmq_bind: %s\n", zmq_strerror(errno));
		return -1;
	}

	rc = zmq_msg_init(&msg);
	if (rc != 0) {
		printf("error in zmq_msg_init: %s\n", zmq_strerror(errno));
		return -1;
	}

	while (1) {
		rc = zmq_recvmsg(s, &msg, 0);
		if (rc < 0) {
			printf("error in zmq_recvmsg: %s\n",
			       zmq_strerror(errno));
			break;
		}

		rc = zmq_sendmsg(s, &msg, 0);
		if (rc < 0) {
			printf("error in zmq_sendmsg: %s\n",
			       zmq_strerror(errno));
			break;
		}
	}

	zmq_close(s);
	zmq_ctx_term(ctx);
}

