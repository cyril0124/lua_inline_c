#!/bin/bash

PRJ_DIR=$(dirname $(realpath $0))

export LUA_PATH="\
$LUA_PATH\
$PRJ_DIR/?/?.lua;\
$PRJ_DIR/?.lua;\
"