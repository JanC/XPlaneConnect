#!/bin/bash

SCRIPT_DIR=$(dirname $0)
. ${SCRIPT_DIR}/.env

echo "Build macOS"
cd $XPC_PLUGIN_PATH
xcodebuild clean build CONFIGURATION_BUILD_DIR="."


