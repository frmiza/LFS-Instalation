#!/bin/bash
set -e
cd $LFS/sources
tar -xf linux-*.tar.xz
cd linux-*/

make mrproper

make headers
find usr/include -name '.*' -delete
rm usr/include/Makefile
cp -rv usr/include $LFS/usr

cd $LFS/sources
rm -rf linux-*/
