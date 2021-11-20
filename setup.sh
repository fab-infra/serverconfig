#!/bin/bash
#
# Run server setup
#

# Script variables
SCRIPT_DIR=`dirname "$0"`
TARGET_HOST="${1:-$(hostname -f)}"

# Check env
if ! command -v ansible-playbook >/dev/null 2>&1; then
	echo "ERROR: ansible-playbook command not found, please make sure Ansible is installed"
	exit 1
fi

# Run playbook
pushd "$SCRIPT_DIR" >/dev/null 2>&1
ansible-playbook -i "inventory" -c "local" -l "$TARGET_HOST" "${@:2}" "serverconfig.yml"
RET=$?
popd >/dev/null 2>&1

exit $RET
