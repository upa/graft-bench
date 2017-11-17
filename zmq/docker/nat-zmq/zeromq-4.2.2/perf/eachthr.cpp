/*
 * zeromq message mirror for benchmarking.
 */


#include "../include/zmq.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <pthread.h>

static int stop_trigger = 0;

void *timer_thread(void *arg)
{
	int duration;

	duration = *((int *)arg);
	sleep(duration);

	stop_trigger = 1;

	return NULL;
}

int main(int argc, char **argv)
{
	const char *connect_to;
	void *ctx;
	void *s;
	int rc;
	zmq_msg_t msg;
	size_t message_size;
	int duration;
	pthread_t tid;


	if (argc != 4) {
		printf("usage: eachthr <connect-to> <message-size> "
		       "<duration>\n");
		return 1;
	}
	connect_to = argv[1];
	message_size = atoi(argv[2]);
	duration = atoi(argv[3]);


	ctx = zmq_init(1);

	if (!ctx) {
		printf("error in zmq_init: %s\n", zmq_strerror(errno));
		return -1;
	}

	s = zmq_socket(ctx, ZMQ_PUSH);
	if (!s) {
		printf("error in zmq_socket: %s\n", zmq_strerror(errno));
		return -1;
	}

	rc = zmq_connect(s, connect_to);
	if (rc != 0) {
		printf("error in zmq_connect: %s\n", zmq_strerror(errno));
		return -1;
	}


	pthread_create(&tid, NULL, timer_thread, &duration);

	while (1) {

		if (stop_trigger)
			break;

		rc = zmq_msg_init_size(&msg, message_size);
		if (rc != 0) {
			printf("error in zmq_msg_init_size: %s\n",
			       zmq_strerror(errno));
			return -1;
		}

		rc = zmq_sendmsg(s, &msg, 0);
		if (rc < 0) {
			printf("error in zmq_sendmsg: %s\n",
			       zmq_strerror(errno));
			break;
		}

		zmq_msg_close(&msg);
	}



	zmq_close(s);
	zmq_ctx_term(ctx);
}

