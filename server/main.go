/*
 *
 * Copyright 2017 gRPC authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

package main

import (

	"flag"
	"math"
	"net"
	"net/http"
	_ "net/http/pprof"
	"time"

	"google.golang.org/grpc/benchmark"
	"google.golang.org/grpc/grpclog"

	"fmt"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials"
)

var (
	duration = flag.Int("duration", math.MaxInt32, "The duration in seconds to run the benchmark server")
	address = flag.String("address", ":0", "ADDRESS:PORT for listen")

	crt = "key/server.crt"
	key = "key/server.key"
)


func main() {
	flag.Parse()

	// Create the TLS credentials
	creds, err := credentials.NewServerTLSFromFile(crt, key)
	if err != nil {
		fmt.Errorf("could not load TLS keys: %s", err)
	}
	c := grpc.Creds(creds)
	fmt.Printf("%v", c)

	go func() {
		lis, err := net.Listen("tcp", *address)
		if err != nil {
			grpclog.Fatalf("Failed to listen: %v", err)
		}
		grpclog.Println("Server profiling address: ", lis.Addr().String())
		if err := http.Serve(lis, nil); err != nil {
			grpclog.Fatalf("Failed to serve: %v", err)
		}
	}()
	addr, stopper := benchmark.StartServer(benchmark.ServerInfo{Addr: ":0", Type: "protobuf"}, c)

	grpclog.Println("Server Address: ", addr)
	<-time.After(time.Duration(*duration) * time.Second)
	stopper()
}
