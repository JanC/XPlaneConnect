#!/bin/sh

SCRIPT_DIR=$(dirname $0)
source ${SCRIPT_DIR}/.env

echo "Build macOS"
cd $XPC_PLUGIN_PATH
xcodebuild clean build