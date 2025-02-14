#!/bin/bash

# Abort on Error
set -e

# Determine toolpath if not set already
relativepath="./" # Define relative path to go from this script to the root level of the tool
if [[ ! -v toolpath ]]; then scriptpath=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ); toolpath=$(realpath --canonicalize-missing ${scriptpath}/${relativepath}); fi

# Load Configuration
source "${toolpath}/config.sh"

# Load Functions
source "${toolpath}/functions.sh"

# Change Folder to Build Root
cd "${BUILD_ROOT}" || exit



apt-get install -y \
  libapparmor-dev


sudo apt-get install \
  git \
  iptables \
  libassuan-dev \
  libbtrfs-dev \
  libc6-dev \
  libdevmapper-dev \
  libglib2.0-dev \
  libgpgme-dev \
  libgpg-error-dev \
  libprotobuf-dev \
  libprotobuf-c-dev \
  libseccomp-dev \
  libselinux1-dev \
  libsystemd-dev \
  make \
  pkg-config \
  uidmap


# DISABLED from the above command
# Needs to be revised since many dependencies have been installed from source anyways (crun, netavark, ...)
#  btrfs-progs \
#  crun \
#  netavark \
#  go-md2man \
#  golang-go \


# Dependencies for building crun
sudo apt-get install -y make git gcc build-essential pkgconf libtool \
   libsystemd-dev libprotobuf-c-dev libcap-dev libseccomp-dev libyajl-dev \
   autoconf python3 automake

# DISABLED from the above command
#go-md2man


# Dependencies for building slirp4netns
sudo apt-get install libglib2.0-dev libslirp-dev libcap-dev libseccomp-dev

# Dependencies for fuse-overlayfs
apt install libfuse3-dev

# Dependencies to build Toolbox
apt install libsubid-dev

# Dependencies to install Protoc
apt install unzip
