#!/bin/bash

# Abort on Error
# set -e

# Determine toolpath if not set already
relativepath="./" # Define relative path to go from this script to the root level of the tool
if [[ ! -v toolpath ]]; then scriptpath=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ); toolpath=$(realpath --canonicalize-missing ${scriptpath}/${relativepath}); fi

# Load Configuration
source "${toolpath}/config.sh"

# Load Functions
source "${toolpath}/functions.sh"

# Change Folder to Build Root
cd "${BUILD_ROOT}" || exit

# Required Fix otherwise go complains about 1.22.6 vs 1.23 mismatch
export PATH="$GOPATH:$PATH"

git_clone_update https://github.com/containers/crun.git crun
cd crun

if [[ -n "${CRUN_TAG}" ]]
then
   git checkout "${CRUN_TAG}"
else
   git checkout $(get_latest_tag)
fi

# On Fedora the Following Flags/Features are additionally enabled compared to Debian in the built runtime: +LIBKRUN +WASM:wasmedge

./autogen.sh
./configure
make
sudo make install


####make BUILDTAGS="selinux seccomp apparmor"

###sudo cp crun /usr/local/bin/crun
