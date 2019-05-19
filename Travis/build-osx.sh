#!/bin/bash

SCRIPT_DIR=$(dirname $0)
. ${SCRIPT_DIR}/.env

echo "Build macOS"
cd $XPC_PLUGIN_PATH
# xcodebuild clean build CONFIGURATION_BUILD_DIR="."

BINRAY=${PWD}/mac.xpl

cp ../xpcPlugin/XPlaneConnect/mac.xpl ~/$TRAVIS_BUILD_NUMBER

if [ -f ${BINRAY} ]; then
    echo "## Copying macOS Binray ##"
    echo "${BINRAY}"
    cp "${BINRAY}" ~/$TRAVIS_BUILD_NUMBER
fi


