#!/bin/bash
#
# Update the current working copy from VCS
#

# Script variables
SCRIPT_DIR=`dirname "$0"`

# Check working copy
if [ -e "$SCRIPT_DIR/.git" ]; then
	# Check Git
	if ! command -v git >/dev/null 2>&1; then
		echo "ERROR: git command not found, please make sure git is installed"
		exit 1
	fi

	# Update working copy
	echo "Updating setup working copy ..."
	if ! ( cd "$SCRIPT_DIR" && git pull ); then
		echo "ERROR: setup working copy update failed"
		exit 1
	else
		echo "Working copy updated successfully, you may run $SCRIPT_DIR/setup.sh now"
	fi

elif [ -e "$SCRIPT_DIR/.svn" ]; then
	# Check SVN
	if ! command -v svn >/dev/null 2>&1; then
		echo "ERROR: svn command not found, please make sure subversion is installed"
		exit 1
	fi

	# Update working copy
	echo "Updating setup working copy ..."
	if ! svn update "$SCRIPT_DIR" --no-auth-cache; then
		echo "ERROR: setup working copy update failed"
		exit 1
	else
		echo "Working copy updated successfully, you may run $SCRIPT_DIR/setup.sh now"
	fi

else
	echo "ERROR: setup directory is not a working copy"
	exit 1
fi
