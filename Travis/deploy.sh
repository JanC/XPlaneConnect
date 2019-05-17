#!/bin/bash
SCRIPT_DIR=$(dirname $0)
. ${SCRIPT_DIR}/.env

echo "Running deploy script "
ls -al $XPC_PLUGIN_PATH