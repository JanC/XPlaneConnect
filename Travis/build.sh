#!/bin/bash

SCRIPT_DIR=$(dirname $0)

OS_BUILD_SCRIPT="${SCRIPT_DIR}/build-${TRAVIS_OS_NAME}.sh"

if [ ! -f ${OS_BUILD_SCRIPT} ]; then
    echo "OS build script does not exist: '${OS_BUILD_SCRIPT}'"
    exit 1
fi

echo "Running script '${OS_BUILD_SCRIPT}' for '${TRAVIS_OS_NAME}'"
${OS_BUILD_SCRIPT}