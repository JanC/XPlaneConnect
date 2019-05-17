#!/bin/bash

SCRIPT_DIR=$(dirname $0)
. ${SCRIPT_DIR}/.env

echo "Build Linux"
cd $XPC_PLUGIN_PATH

# https://askubuntu.com/questions/530248/asm-errno-h-no-such-file-or-directory
if [ ! -f /usr/include/asm ]; then
    ln -s /usr/include/asm-generic/ /usr/include/asm
fi

# pass the compiler version from the Travis env
cmake -D CMAKE_C_COMPILER=${CC} -D CMAKE_CXX_COMPILER=${CXX} .
make