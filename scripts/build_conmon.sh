#!/bin/bash

# Abort on Error
# set -e

# Determine toolpath if not set already
relativepath="../" # Define relative path to go from this script to the root level of the tool
if [[ ! -v toolpath ]]; then scriptpath=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ); toolpath=$(realpath --canonicalize-missing ${scriptpath}/${relativepath}); fi

# Load Configuration
source "${toolpath}/config.sh"

# Load Functions
source "${toolpath}/functions.sh"

# Change Folder to Build Root
cd "${BUILD_ROOT}" || exit


git_clone_update https://github.com/containers/conmon conmon
cd conmon
git_checkout "${CONMON_TAG}"

# Log Component
log_component "conmon"

# Build
export GOCACHE="$(mktemp -d)"
make
sudo make podman
