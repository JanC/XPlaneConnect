#!/usr/bin/env bash

SCRIPT_DIR=$(dirname $0)
. ${SCRIPT_DIR}/.env

echo "Copying compiled binaries"
cd $XPC_PLUGIN_PATH

if [ -z "${AWS_SYNC_FOLDER}" ]; then
    echo "AWS_SYNC_FOLDER env not set"
    exit 1
fi

mkdir -p ~/${AWS_SYNC_FOLDER}/64/

function copy_binary() {
    local binary_path=$1
    local binary_dst_path=$2

    if [ -f "${binary_path}" ]; then
        echo "Copying ${binary_path} to ${binary_dst_path}"
        cp ${binary_path} ${binary_dst_path}
    fi
}
echo "PWD: ${PWD}"

copy_binary "${PWD}/xpc-osx-64.xpl" ~/${AWS_SYNC_FOLDER}/mac.xpl

copy_binary "${PWD}/xpc-linux-64.xpl" ~/${AWS_SYNC_FOLDER}/64/lin.xpl
copy_binary "${PWD}/xpc-linux-32.xpl" ~/${AWS_SYNC_FOLDER}/lin.xpl
 
copy_binary "${PWD}/xpc-windows-64.xpl" ~/${AWS_SYNC_FOLDER}/64/win.xpl
copy_binary "${PWD}/xpc-windows-32.xpl" ~/${AWS_SYNC_FOLDER}/win.xpl
