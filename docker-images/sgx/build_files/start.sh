#!/bin/bash

LUASGX=./luasgx
LUA_DIR=/var/lua
SGX=/dev/isgx


if [[ ! (-c $SGX) ]]; then
    echo "Device $SGX not found"
    echo "Use 'docker run' flag --device: --device=$SGX"
    exit 0
fi

if [[ -z $1 ]]; then
    echo "No file provided - you have to pass the filename of the LUA code as argument"
    exit 1
fi

if [[ ! (-e $LUA_DIR) ]]; then
    echo "No volume mounted - you have to mount a volume including the LUA code you want to embed in the container"
    echo "Use 'docker run' flag -v: -v /my/lua/src:$LUA_DIR"
    exit 0
fi

if [[ ! (-e $LUA_DIR/$1) ]]; then
    echo "File $LUA_DIR/$1 not found"
    exit 0
fi


echo "Run AESM service"
/opt/intel/sgxpsw/aesm/aesm_service &


echo "Wait 1s for AESM service to be up"
sleep 1

echo "Copy source files from $LUA_DIR into $(pwd)"
cp -r $LUA_DIR/* .

echo "Run LUA_PATH='$LUA_DIR/?.lua;;' $LUASGX $LUA_DIR/$1"
LUA_PATH="$LUA_DIR/?.lua;;" $LUASGX $LUA_DIR/$1


#echo "Run bash for debugging"
#bash
