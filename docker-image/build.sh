#!/usr/bin/env bash

IMAGE=zmqrxlua-poc:lua-5.3

cp -f ../experiment/zmq-rx.lua build_files/zmq-rx.lua
docker build -t $IMAGE .
