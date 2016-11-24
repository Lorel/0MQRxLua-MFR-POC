#!/usr/bin/env bash

IMAGE=lorel/zmqrxlua-poc:back-to-push-pull

cp -f ../experiment/zmq-rx.lua build_files/zmq-rx.lua
docker build -t $IMAGE .
