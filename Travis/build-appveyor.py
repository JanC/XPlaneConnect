#!/usr/bin/env python3
import json
import time
import os
import logging
import sys
from pathlib import Path
import requests
from appveyor_client import AppveyorClient


# pip3 install git+https://github.com/JanC/appveyor-client.git@artifacts
# usage 
# export APPVEYOR_ACCOUNT=JanC 
# export APPVEYOR_PROJECT=xplaneconnect 
# export APPVEYOR_API_KEY=xxxx
# export OUT_DIR=/tmp/test

# for commit builds:
# GIT_COMMIT=d60349d71e5dc3452b7a686d0d4390a57df0aad1 GIT_BRANCH=travis-appveyor  ./Travis/build-appveyor.py

# for PR builds
# GIT_PULL_REQUEST=2 ./Travis/build-appveyor.py

logging.basicConfig(level=logging.INFO)

account = os.environ['APPVEYOR_ACCOUNT'] #'JanC'
project = os.environ['APPVEYOR_PROJECT'] #'xplaneconnect'
api_key = os.environ['APPVEYOR_API_KEY'] #'appveyor'
out_dir = os.environ['OUT_DIR'] #'appveyor'

pull_request_number = os.environ.get('GIT_PULL_REQUEST', None)
commit = os.environ.get('GIT_COMMIT', None)
branch = os.environ.get('GIT_BRANCH', None)

# Travis passes a 'false' value when the build is not a pull request
if pull_request_number == "false":
    pull_request_number = None

def start_build(client, branch, commit, pull_request_number):
    if pull_request_number is not None:
        commit = None # if both are supplied, use PR
        logging.info("Starting AppVeyor build on PR {pull_request_number}".format(pull_request_number=pull_request_number))
    elif commit is not None:
        logging.info("Starting AppVeyor build on branch {branch} commit {commit}".format(branch=branch, commit=commit))
    else:
        raise ValueError('Either GIT_PULL_REQUEST or GIT_COMMIT env must be specified')
    
    build = client.builds.start(account, project, commit=commit, pull_request_number=pull_request_number)
    # print(json.dumps(build))

    # Get the build version from
    build_version = build['version']
    build_status = build['status']
    logging.info("Build version {build_version} start status is {build_status}".format(build_version=build_version, build_status=build_status))
    return build


def poll_build(client, build_version):
    logging.info("Polling for build status version {}".format(build_version))
    # Poll while the build is running
    # build_version = "1.0.29"
    build = None
    status = None
    while status == 'running' or status == 'starting' or status == 'queued' or build is None:
        if status is not None:
            time.sleep(5)

        result = client.projects.build(account, project, build_version = build_version)
        build = result['build']
        status = build['status']
        logging.info("Appvoyer build status is '{}'".format(status))
        
    if status != 'success':
        exit(1)
    return build

def download_artifact(destination_directory, artifact_file_name, artifact_url):
    logging.info("Downloading artifact '{artifact_file_name}'".format(artifact_file_name=artifact_file_name))
    request = requests.get(artifact_url, allow_redirects=True)

    file_path = os.path.join(destination_directory, artifact_file_name)
    out_dir = os.path.dirname(file_path)
    path = Path(out_dir)
    path.mkdir(parents=True, exist_ok=True)
    logging.info("Writing artifcat to {}".format(file_path))
    open(file_path, 'wb').write(request.content)

def download_artifacts(client, build, destination_directory):
    #job_id = '9gnwou96uci5iytr'
    for job in build['jobs']:
        job_id = job['jobId']
        logging.info("Artifacts for job {}: ".format(job_id))
        
        artifacts = client.buildjobs.artifacts(job_id)
        
        for artifact in artifacts:
            file_name = artifact['fileName']
            file_url = client.buildjobs.artifact_url(job_id, file_name)
            logging.info("""
                File name: {file_name}
                Download URL: {file_url}
                """.format(file_name=file_name, file_url=file_url))

            download_artifact(destination_directory, file_name, file_url)


def main():
    logging.info("""Starting appveyor build with
    pull_request_number: {pull_request_number}
    commit: {commit}
    branch: {branch}
    """.format(pull_request_number=pull_request_number, commit=commit, branch=branch))

    client = AppveyorClient(api_key)            

    build = start_build(client, branch, commit, pull_request_number)
    build_version = build['version']

    # build_version = "1.0.51"
    
    build = poll_build(client, build_version = build_version)
    download_artifacts(client, build, out_dir)

main()


logging.info("Done")