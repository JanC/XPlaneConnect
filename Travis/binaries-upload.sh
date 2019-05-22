#!/usr/bin/env bash

SCRIPT_DIR=$(dirname $0)
. ${SCRIPT_DIR}/.env

echo "Uploading compiled binaries to AWS"

ls -lR ~/$TRAVIS_BUILD_NUMBER

aws s3 sync ~/$TRAVIS_BUILD_NUMBER s3://aeronavmap/$TRAVIS_BUILD_NUMBER

