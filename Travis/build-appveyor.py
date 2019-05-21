#!/usr/bin/env python3
import json
import time
import os
from appveyor_client import AppveyorClient


# pip3 install git+https://github.com/JanC/appveyor-client.git@artifacts
# usage:
# APPVEYOR_ACCOUNT=JanC APPVEYOR_PROJECT=xplaneconnect GIT_COMMIT=d60349d71e5dc3452b7a686d0d4390a57df0aad1 GIT_BRANCH=travis-appveyor APPVEYOR_API_KEY=xxxx ./build.py


account = os.environ['APPVEYOR_ACCOUNT'] #'JanC'
project = os.environ['APPVEYOR_PROJECT'] #'xplaneconnect'
api_key = os.environ['APPVEYOR_API_KEY'] #'appveyor'
commit = os.environ['GIT_COMMIT'] #'1d9427ad'
branch = os.environ['GIT_BRANCH'] #'appveyor'

client = AppveyorClient(api_key)


# Start the build
print("Starting AppVeyor build on branch {branch} commit {commit}".format(branch=branch, commit=commit))
build = client.builds.start(account, project, commit=commit)
# print(json.dumps(build))

# Get the build version from
# build_version = "1.0.29"
build_version = build['version']
build_status = build['status']

print("Build version {build_version} start status is {build_status}".format(build_version=build_version, build_status=build_status))

# Poll while the build is running

build = None
status = None
while status == 'running' or status == 'starting' or status == 'queued' or build is None:
    if status is not None:
        time.sleep(5)

    result = client.projects.build(account, project, build_version = build_version)
    build = result['build']
    status = build['status']
    print("Appvoyer build status is '{}'".format(status))
    
if status != 'success':
    exit(1)

# For all jobs, get artifacts    

#job_id = '9gnwou96uci5iytr'
for job in build['jobs']:
    job_id = job['jobId']
    print("\nArtifacts for job {}: ".format(job_id))
    
    artifacts = client.buildjobs.artifacts(job_id)
    
    for artifact in artifacts:
        file_name = artifact['fileName']
        file_url = client.buildjobs.artifact_url(job_id, file_name)
        print("{file_name}: {file_url}".format(file_name=file_name, file_url=file_url))

        # Todo actual download

print("Done")