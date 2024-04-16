#!/bin/bash

PRJ_DIR=$(realpath .)

export LUA_PATH="\
$LUA_PATH\
$PRJ_DIR/?/?.lua;\
"