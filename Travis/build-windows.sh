#!/usr/bin/env bash

# MSBuild.exe xpcPlugin/xpcPlugin/xpcPlugin.sln /p:Configuration=Release
# MSBuild.exe xpcPlugin/xpcPlugin/xpcPlugin.sln /p:Configuration=Release /p:Platform=x64

pwd
MSBuild.exe
ls
choco install awscli