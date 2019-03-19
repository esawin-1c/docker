#!/usr/bin/env bash
set -e

# get all the ppas we might need
add-apt-repository -y ppa:valhalla-core/valhalla
apt-get update -y

# get all the dependencies might need
apt-get install -y \
  git \
  autoconf \
  automake \
  make \
  libtool \
  pkg-config \
  g++ \
  gcc \
  jq \
  lcov \
  protobuf-compiler \
  vim-common \
  libboost-all-dev \
  libboost-all-dev \
  libcurl4-openssl-dev \
  zlib1g-dev \
  liblz4-dev \
  libprime-server0.6.3-dev \
  libprotobuf-dev prime-server0.6.3-bin \
  libgeos-dev \
  libgeos++-dev \
  liblua5.2-dev \
  libspatialite-dev \
  libsqlite3-dev \
  spatialite-bin \
  wget \
  unzip \
  lua5.2 \
  locales \
  python-all-dev \
  cmake \
  pkg-config \
  nodejs \
  npm \
  curl 
  

if [[ $(grep -cF xenial /etc/lsb-release) > 0 ]]; then
  apt-get install -y libsqlite3-mod-spatialite
fi

# get the software installed
git clone \
  --depth=1 \
  --recurse-submodules \
  --single-branch \
  --branch=3.0.0 \
  https://github.com/valhalla/valhalla.git libvalhalla

cd libvalhalla
git submodule update --init --recursive
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DENABLE_NODE_BINDINGS=OFF
make -j$(nproc)
make install
cd -

# clean up
ldconfig
rm -rf libvalhalla
