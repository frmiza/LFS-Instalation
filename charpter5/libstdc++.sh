#!/bin/bash
set -e
cd $LFS/sources
tar -xf gcc-*.tar.xz
cd gcc-*/

mkdir -pv build
cd build

../libstdc++-v3/configure           \
    --host=$LFS_TGT                 \
    --build=$(../config.guess)      \
    --prefix=/usr                   \
    --disable-multilib              \
    --disable-nls                   \
    --disable-libstdcxx-pch         \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/11.2.0

make && make install
cd $LFS/sources
rm -rf gcc-*/
