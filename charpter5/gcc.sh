#!/bin/bash

mkdir mpfr gmp mpc
tar xvf ../mpfr-*.tar.xz -C ./mpfr  --strip-component=1
tar xvf ../gmp-*.tar.xz -C ./gmp    --strip-component=1 
tar xvf ../mpc-*.tar.gz -C ./mpc    --strip-component=1

case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
 ;;
esac

mkdir -pv build
cd build

../configure                  \
  --target=$LFS_TGT           \
  --prefix=$LFS/tools         \
  --with-glibc-version=2.11   \
  --with-sysroot=$LFS         \
  --with-newlib               \
  --without-headers           \
  --enable-initfini-array     \
  --disable-nls               \
  --disable-shared            \
  --disable-multilib          \
  --disable-decimal-float     \
  --disable-threads           \
  --disable-libatomic         \
  --disable-libgomp           \
  --disable-libquadmath       \
  --disable-libssp            \
  --disable-libvtv            \
  --disable-libstdcxx         \
  --enable-languages=c,c++    \

make \
&& sudo make install

cd ..

cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/install-tools/include/limits.h
