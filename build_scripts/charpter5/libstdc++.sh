source build_scripts/file-processing-start.sh gcc

VERSION=$(ls $LFS/sources/gcc-*.tar.xz | sed 's/.*-\(.*\).tar\..*/\1/')

mkdir -pv build
cd build

../libstdc++-v3/configure           \
    --host=$LFS_TGT                 \
    --build=$(../config.guess)      \
    --prefix=/usr                   \
    --disable-multilib              \
    --disable-nls                   \
    --disable-libstdcxx-pch         \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/$VERSION

make && make install

source build_scripts/file-cleanup.sh gcc
