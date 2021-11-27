#!/bin/bash
#
# Test server setup
#

# Script variables
SCRIPT_DIR=`dirname "$0"`
TARGET_OS="${1:-centos7}"

# Run container
pushd "$SCRIPT_DIR" >/dev/null 2>&1
docker-compose build "$TARGET_OS"
docker-compose run --rm "$TARGET_OS"
RET=$?
popd >/dev/null 2>&1

exit $RET
