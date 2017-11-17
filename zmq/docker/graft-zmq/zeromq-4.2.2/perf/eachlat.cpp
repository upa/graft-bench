/*
 * zeromq message mirror for benchmarking.
 */


#include "../include/zmq.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv)
{
	const char *connect_to;
	void *ctx;
	void *s;
	void *watch;
	int rc, n;
	zmq_msg_t msg;
	size_t message_size;
	int roundtrip_count;
	double latency;
	unsigned long elapsed;


	if (argc != 4) {
		printf("usage: eachlat <connect-to> <message-size> "
		       "<roundtrip-count>\n");
		return 1;
	}
	connect_to = argv[1];
	message_size = atoi(argv[2]);
	roundtrip_count = atoi(argv[3]);


	ctx = zmq_init(1);

	if (!ctx) {
		printf("error in zmq_init: %s\n", zmq_strerror(errno));
		return -1;
	}

	s = zmq_socket(ctx, ZMQ_REQ);
	if (!s) {
		printf("error in zmq_socket: %s\n", zmq_strerror(errno));
		return -1;
	}

	rc = zmq_connect(s, connect_to);
	if (rc != 0) {
		printf("error in zmq_connect: %s\n", zmq_strerror(errno));
		return -1;
	}

	rc = zmq_msg_init_size(&msg, message_size);
	if (rc != 0) {
		printf("error in zmq_msg_init_size: %s\n",
		       zmq_strerror(errno));
		return -1;
	}
	memset(zmq_msg_data(&msg), 0, message_size);


	for (n = 0; n < roundtrip_count; n++) {

		watch = zmq_stopwatch_start();

		rc = zmq_sendmsg(s, &msg, 0);
		if (rc < 0) {
			printf("error in zmq_sendmsg: %s\n",
			       zmq_strerror(errno));
			break;
		}

		rc = zmq_recvmsg(s, &msg, 0);

		elapsed = zmq_stopwatch_stop(watch);

		if (rc < 0) {
			printf("error in zmq_recvmsg: %s\n",
			       zmq_strerror(errno));
			break;
		}

		latency = (double) elapsed;
		printf("%.3f [us]\n", (double) latency);
	}

	zmq_msg_close(&msg);

	zmq_close(s);
	zmq_ctx_term(ctx);
}

