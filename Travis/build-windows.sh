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

echo "ls studio"
ls -al "/C/Program Files (x86)/Microsoft Visual Studio/2017/BuildTools/MSBuild/15.0/Bin"

cmd.exe /C '/C/Program Files (x86)/Microsoft Visual Studio/2017/BuildTools/MSBuild/15.0/Bin/MSBuild.exe "xpcPlugin/xpcPlugin/xpcPlugin.sln /p:Configuration=Release'
echo "Done"

# echo $PATH
# export PATH=$MSBUILD_PATH:$PATH
# echo $PATH
# # pwd
# # MSBuild.exe

# ls -al "$MSBUILD_PATH"
# MSBuild.exe --help
# choco install awscli