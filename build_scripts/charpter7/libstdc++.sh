source $DIST_ROOT/LFS-instalation/build_scripts/file-processing-start.sh gcc

ln -s gthr-posix.h libgcc/gthr-default.h

mkdir -v build
cd build



../libstdc++-v3/configure            \
    CXXFLAGS="-g -O2 -D_GNU_SOURCE"  \
    --prefix=/usr                    \
    --disable-multilib               \
    --disable-nls                    \
    --host=$(uname -m)-lfs-linux-gnu \
    --disable-libstdcxx-pch

make && make install

source $DIST_ROOT/LFS-instalation/build_scripts/file-cleanup.sh gcc
