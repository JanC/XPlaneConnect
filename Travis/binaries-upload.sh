#!/usr/bin/env bash

SCRIPT_DIR=$(dirname $0)
. ${SCRIPT_DIR}/.env

echo "Uploading compiled binaries to AWS"

if [ -z "${AWS_BUCKET_NAME}" ]; then
    echo "AWS_BUCKET_NAME env not set"
    exit 1
fi

if [ -z "${AWS_SYNC_FOLDER}" ]; then
    echo "AWS_SYNC_FOLDER env not set"
    exit 1
fi

ls -lR ~/${AWS_SYNC_FOLDER}

aws s3 sync ~/${AWS_SYNC_FOLDER} s3://${AWS_BUCKET_NAME}/${AWS_SYNC_FOLDER}

