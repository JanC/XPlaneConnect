#!/usr/bin/env bash

# MSBuild.exe xpcPlugin/xpcPlugin/xpcPlugin.sln /p:Configuration=Release
# MSBuild.exe xpcPlugin/xpcPlugin/xpcPlugin.sln /p:Configuration=Release /p:Platform=x64

echo "Building Windows"
echo "ls /usr/bin"
ls -al /usr/bin

#echo "ls $MSBUILD_PATH"
#ls -al "$MSBUILD_PATH"

#file $MSBUILD_PATH/MSBuild.exe
echo "PATH: $PATH"

MSBuild.exe xpcPlugin/xpcPlugin/xpcPlugin.sln //p:Configuration=Release
echo "Done"

# echo $PATH
# export PATH=$MSBUILD_PATH:$PATH
# echo $PATH
# # pwd
# # MSBuild.exe

# ls -al "$MSBUILD_PATH"
# MSBuild.exe --help
# choco install awscli