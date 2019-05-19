#!/bin/bash
SCRIPT_DIR=$(dirname $0)
. ${SCRIPT_DIR}/.env

echo "Running deploy zip script "
mkdir XPlaneConnect
cp -r ~/$TRAVIS_BUILD_NUMBER/* XPlaneConnect
zip -r XPlaneConnect.zip XPlaneConnect
cp XPlaneConnect.zip ~/$TRAVIS_BUILD_NUMBER

