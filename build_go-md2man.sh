#!/bin/bash

# Abort on Error
set -e

# Determine toolpath if not set already
relativepath="./" # Define relative path to go from this script to the root level of the tool
if [[ ! -v toolpath ]]; then scriptpath=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ); toolpath=$(realpath --canonicalize-missing ${scriptpath}/${relativepath}); fi

# Load Configuration
source ${toolpath}/config.sh

# Change Folder to Build Root
cd "${BUILD_ROOT}" || exit

# Required Fix otherwise go complains about 1.22.6 vs 1.23 mismatch
export PATH="$GOPATH:$PATH"

git clone https://github.com/cpuguy83/go-md2man.git
cd go-md2man
git checkout "${GOMD2MAN_TAG}"

# Must Patch 1.22.6 -> 1.23 in /usr/src/podman/buildah/go.mod
sed -Ei "s|^go 1.22.6$|go 1.23|" go.mod

make

cp bin/go-md2man /usr/local/bin
