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

# Required Fix otherwise go complains about 1.22.6 vs 1.23 mismatch
export PATH="$GOPATH:$PATH"

git_clone_update https://github.com/containers/fuse-overlayfs.git fuse-overlayfs
cd fuse-overlayfs
git_checkout "${FUSE_OVERLAYFS_TAG}"

./autogen.sh
LIBS="-ldl" LDFLAGS="-static" ./configure --prefix /usr/local 
make
sudo make install

#./autogen.sh
#./configure
#make
#sudo make install


####make BUILDTAGS="selinux seccomp apparmor"

####sudo cp fuse-overlayfs /usr/local/bin/fuse-overlayfs
