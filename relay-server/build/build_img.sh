./#!/bin/bash

BASE_DIR=`dirname $(realpath "$0")`/../..
cd $BASE_DIR
[[ "$REPO" == "" ]] && REPO="sibashi/kubearmor-relay-server"

# check version

VERSION=latest

if [ ! -z $1 ]; then
    VERSION=$1
fi

# remove old images
docker images | grep kubearmor-relay-server | awk '{print $3}' | xargs -I {} docker rmi -f {} 2> /dev/null
echo "[INFO] Removed existing $REPO images"

# build image
echo "[INFO] Building $REPO:$VERSION"
docker build -t $REPO:$VERSION . -f $BASE_DIR/relay-server/Dockerfile

if [ $? != 0 ]; then
    echo "[FAILED] Failed to build $REPO:$VERSION"
    exit 1
fi
echo "[PASSED] Built $REPO:$VERSION"
