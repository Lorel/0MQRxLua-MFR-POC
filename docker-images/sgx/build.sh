#!/usr/bin/env bash

IMAGE=lorel/zmqrxlua-poc:lua-sgx

#cp -f ../experiment/zmq-rx.lua build_files/zmq-rx.lua
docker build -t $IMAGE .
