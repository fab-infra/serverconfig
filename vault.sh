#!/bin/bash
#
# Ansible Vault utility
#

# Script variables
SCRIPT_DIR=`dirname "$0"`
VAULT_PASSWORD_FILE="$SCRIPT_DIR/vault.password"

# Check env
if ! command -v ansible-vault >/dev/null 2>&1; then
	echo "ERROR: ansible-vault command not found, please make sure Ansible is installed"
	echo
	echo "You may try the following commands:"
	echo "  python3 -m pip install --upgrade pip"
	echo "  python3 -m pip install ansible"
	exit 1
fi

# Load vault password
if [ -e "$VAULT_PASSWORD_FILE" ]; then
	chmod a-x "$VAULT_PASSWORD_FILE"
	export ANSIBLE_VAULT_PASSWORD_FILE=`realpath "$VAULT_PASSWORD_FILE"`
fi

# Run vault
ansible-vault "$@"
