#!/bin/bash

set -euf -o pipefail

CMAKE=cmake
NINJA=ninja

SCRIPT_PATH=$(cd $(dirname $0) ; pwd -P)

HOST_BUILD_DEBUG="./build/host-debug"
TARGET_BUILD_DEBUG="./build/target-debug"

mkdir -p $HOST_BUILD_DEBUG && mkdir -p $TARGET_BUILD_DEBUG

#(cd $HOST_BUILD_DEBUG && cmake -G "Ninja"  -DBUILD_HOST=1 -DCMAKE_BUILD_TYPE=Debug $SCRIPT_PATH)
(cd $TARGET_BUILD_DEBUG && cmake -G "Ninja"  -DBUILD_TARGET=1 -DCMAKE_BUILD_TYPE=Debug $SCRIPT_PATH)

#(
    #cd $HOST_BUILD_DEBUG
    #$NINJA "$@"
    #if [ $# -eq 0 ]; then
        #$NINJA install > /dev/null || true
    #fi
#)

(
    cd $TARGET_BUILD_DEBUG
    $NINJA "$@"
    if [ $# -eq 0 ]; then
        $NINJA install > /dev/null || true
    fi
)
