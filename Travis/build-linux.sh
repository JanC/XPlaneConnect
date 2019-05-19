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
# cmake -D CMAKE_C_COMPILER=${CC} -D CMAKE_CXX_COMPILER=${CXX} .
# make


pwd
ls -al
cp ../xpcPlugin/XPlaneConnect/lin.xpl ~/$TRAVIS_BUILD_NUMBER

if [ -f "${PWD}/xpc64.xpl" ]; then
    echo "##  Copying Linux Binaries ##"
    # echo "${PWD}/xpc32.xpl"
    # echo "${PWD}/xpc64.xpl"
    # cp "${PWD}/xpc32.xpl" ~/$TRAVIS_BUILD_NUMBER
    # cp "${PWD}/xpc64.xpl" ~/$TRAVIS_BUILD_NUMBER
    
    cp ${$XPC_PLUGIN_PATH}/XPlaneConnect/lin.xpl ~/$TRAVIS_BUILD_NUMBER
fi