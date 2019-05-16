#!/bin/sh

SCRIPT_DIR=$(dirname $0)
source ${SCRIPT_DIR}/.env

echo "Step macOS: $PWD"
cd $XPC_PLUGIN_PATH
xcodebuild clean build