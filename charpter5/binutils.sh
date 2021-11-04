#!/bin/bash
set -e 

mkdir -pv build
cd build

../configure --prefix=$LFS/tools \
  --with-sysroot=$LFS \
  --target=$LFS_TGT   \
  --disable-nls       \
  --disable-werror    \

make \
&& sudo make install -j1
