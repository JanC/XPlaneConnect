#!/bin/bash

SCRIPT_DIR=$(dirname $0)
. ${SCRIPT_DIR}/.env

echo "Build Linux"
cd $XPC_PLUGIN_PATH

cmake .
make