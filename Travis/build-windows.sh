#!/usr/bin/env bash

echo "Building Windows"

MSBuild.exe xpcPlugin/xpcPlugin/xpcPlugin.sln //p:Configuration=Release
MSBuild.exe xpcPlugin/xpcPlugin/xpcPlugin.sln //p:Configuration=Release /p:Platform=x64

# MSBuild.exe xpcPlugin/xpcPlugin/xpcPlugin.sln /p:Configuration=Release
echo "Done"

# echo $PATH
# export PATH=$MSBUILD_PATH:$PATH
# echo $PATH
# # pwd
# # MSBuild.exe

# ls -al "$MSBUILD_PATH"
# MSBuild.exe --help
# choco install awscli