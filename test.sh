#!/bin/bash
#
# Test server setup
#

# Script variables
SCRIPT_DIR=`dirname "$0"`
TARGET_OS="${1:-rocky8}"

# Run container
pushd "$SCRIPT_DIR" >/dev/null 2>&1
docker compose build "$TARGET_OS" && docker compose run --rm "$TARGET_OS" "${@:2}"
RET=$?
popd >/dev/null 2>&1

exit $RET
