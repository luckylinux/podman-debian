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

git_clone_update https://passt.top/passt passt
cd passt
git fetch --all
git fetch --tags
git pull

# Save Version
export GIT_CHECKED_OUT_TAG=$(date +"%Y%m%d")

# Log Component
log_component "pasta"

# Build
make

# Kill current running Processes
ps aux | grep pasta | awk '{print $2}' | xargs -n 1 kill -9

# Copy new Executable to Destination Folder
cp passt /usr/local/bin/
cp passt.avx2 /usr/local/bin/
cp pasta /usr/local/bin/
cp pasta.avx2 /usr/local/bin/

# Remove Files that shouldn't have been previously installed
rm -f /usr/local/bin/passt.1
rm -f /usr/local/bin/passt.c
rm -f /usr/local/bin/passt.h
rm -f /usr/local/bin/pasta.1
rm -f /usr/local/bin/pasta.c
rm -f /usr/local/bin/pasta.h
