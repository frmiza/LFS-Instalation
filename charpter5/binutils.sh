#!/bin/bash
set -e 
cd $LFS/sources
tar -xf binutils-*.tar.xz
cd binutils-*/

mkdir -pv build
cd build

../configure --prefix=$LFS/tools \
  --with-sysroot=$LFS \
  --target=$LFS_TGT   \
  --disable-nls       \
  --disable-werror    

make && make install 

cd $LFS/sources
rm -rf binutils-*/ 
