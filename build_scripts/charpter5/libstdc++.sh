source ../file-processing-start.sh $1

VERSION=$(echo $1 | sed 's/.*-\(.*\).tar\..*/\1/')

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

source ../file-cleanup.sh $1
