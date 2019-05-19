#!/usr/bin/env bash

SCRIPT_DIR=$(dirname $0)
. ${SCRIPT_DIR}/.env

echo "Copying compiled binaries"
cd $XPC_PLUGIN_PATH

mkdir -p ~/$TRAVIS_BUILD_NUMBER/64/

if [ "$TRAVIS_OS_NAME" == "osx" ] ; then
    BINRAY=${PWD}/mac.xpl
    cp ../xpcPlugin/XPlaneConnect/mac.xpl ~/$TRAVIS_BUILD_NUMBER
    if [ -f ${BINRAY} ]; then
        echo "## Copying macOS Binray ##"
        echo "${BINRAY}"
        cp "${BINRAY}" ~/$TRAVIS_BUILD_NUMBER
    fi
fi

if [ "$TRAVIS_OS_NAME" == "linux" ] ; then
    # pwd
    # ls -al
    cp ../xpcPlugin/XPlaneConnect/lin.xpl ~/$TRAVIS_BUILD_NUMBER
    cp ../xpcPlugin/XPlaneConnect/64/lin.xpl ~/$TRAVIS_BUILD_NUMBER/64/

    if [ -f "${PWD}/xpc64.xpl" ]; then
        echo "##  Copying Linux Binaries ##"
        cp "${PWD}/xpc32.xpl" ~/$TRAVIS_BUILD_NUMBER/
        cp "${PWD}/xpc64.xpl" ~/$TRAVIS_BUILD_NUMBER/64/
    fi
fi

if [ "$TRAVIS_OS_NAME" == "windows" ]; then
    cp ../xpcPlugin/XPlaneConnect/win.xpl ~/$TRAVIS_BUILD_NUMBER
    cp ../xpcPlugin/XPlaneConnect/64/win.xpl ~/$TRAVIS_BUILD_NUMBER/64/
fi