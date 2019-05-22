#!/usr/bin/env bash

SCRIPT_DIR=$(dirname $0)
. ${SCRIPT_DIR}/.env

echo "Copying compiled binaries"
cd $XPC_PLUGIN_PATH


mkdir -p ~/$TRAVIS_BUILD_NUMBER/64/

function copy_binary() {
    local binary_path=$1
    local binary_dst_path=$2

    if [ -f "${binary_path}" ]; then
        echo "Copying ${binary_path} to ${binary_dst_path}"
        cp ${binary_path} ${binary_dst_path}
    fi
}

copy_binary "${PWD}/xpc-osx-64.xpl" ~/$TRAVIS_BUILD_NUMBER/

copy_binary "${PWD}/xpc-linux-64.xpl" ~/$TRAVIS_BUILD_NUMBER/64
copy_binary "${PWD}/xpc-linux-32.xpl" ~/$TRAVIS_BUILD_NUMBER/

copy_binary "${PWD}/xpc-windows-64.xpl" ~/$TRAVIS_BUILD_NUMBER/64
copy_binary "${PWD}/xpc-windows-32.xpl" ~/$TRAVIS_BUILD_NUMBER/
