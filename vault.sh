#!/bin/bash
#
# Ansible Vault utility
#

# Script variables
SCRIPT_DIR=`dirname "$0"`

# Run container
pushd "$SCRIPT_DIR" >/dev/null 2>&1
docker-compose run --rm vault "$@"
RET=$?
popd >/dev/null 2>&1

exit $RET
