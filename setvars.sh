#!/bin/bash

current_shell=$(ps -p $$ -ocomm=)

if [[ "$current_shell" == *bash* ]]; then
    script_path=$(realpath "${BASH_SOURCE[0]}")
elif [[ "$current_shell" == *zsh* ]]; then
    script_path=$0
else
    echo "Unknown shell"
fi

lua_inline_c_dir=$(dirname $(realpath $script_path))

export LUA_PATH="\
$LUA_PATH\
$lua_inline_c_dir/?/?.lua;\
$lua_inline_c_dir/?.lua;\
"