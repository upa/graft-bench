/*
 * zeromq message mirror for benchmarking.
 */


#include "../include/zmq.h"
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include <pthread.h>

static int caught_signal = 0;
static unsigned long msg_count = 0;
static unsigned long msg_bytes = 0;

static void *ctx;
static void *s;

void sig_handler(int sig)
{
	if (sig == SIGINT)
		caught_signal = 1;
}

void * count_thread(void *arg)
{
	void *watch;
	unsigned long count_old, count_cur, bytes_old, bytes_cur, elapsed;
	double mps, bps;
	int trigger = 0;

	while (1) {
		watch = zmq_stopwatch_start();

		count_old = msg_count;
		bytes_old = msg_bytes;

		sleep(1);

		count_cur = msg_count;
		bytes_cur = msg_bytes;

		elapsed = zmq_stopwatch_stop(watch);


		if (count_cur <= count_old || bytes_cur <= bytes_old) {
			if (!trigger)
				continue;
			else {
				/* skimped work */
				zmq_close(s);
				zmq_ctx_term(ctx);
				return NULL;
			}
		}

		trigger = 1;

		/* message per second */
		mps = (double)(count_cur - count_old) /
			(double)(elapsed) * 1000000;
		bps = (double)(bytes_cur - bytes_old) /
			(double)(elapsed) * 1000000 * 8;

		printf("[msg/s] %.3f [bit/s] %.3f [elapsed] %.3f\n",
		       mps, bps, (double)elapsed);

		if (caught_signal) {
			break;
		}

	}

	return NULL;
}



int main(int argc, char **argv)
{
	const char *bind_to;
	int rc;
	zmq_msg_t msg;
	pthread_t tid;

	if (argc != 2) {
		printf("usage: mirror_thr <bind-to>\n");
		return 1;
	}

	bind_to = argv[1];

	ctx = zmq_init(1);

	if (!ctx) {
		printf("error in zmq_init: %s\n", zmq_strerror(errno));
		return -1;
	}

	s = zmq_socket(ctx, ZMQ_PULL);
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


	/* start count thread */
	if (pthread_create(&tid, NULL, count_thread, NULL) < 0) {
		printf("error to create count thread\n");
		zmq_close(s);
		zmq_ctx_term(ctx);
		return -1;
	}


	if (signal(SIGINT, sig_handler) == SIG_ERR) {
		printf("error to set signal()\n");
		return -1;
	}


	while (1) {
		if (caught_signal)
			break;

		rc = zmq_recvmsg(s, &msg, 0);
		if (rc < 0) {
			printf("error in zmq_recvmsg: %s\n",
			       zmq_strerror(errno));
			break;
		}

		msg_count++;
		msg_bytes += zmq_msg_size(&msg);
	}

	zmq_close(s);
	zmq_ctx_term(ctx);

	caught_signal = 1;

}

