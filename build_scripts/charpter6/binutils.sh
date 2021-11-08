<<<<<<< HEAD
source build_scripts/file-processing-start.sh $(basename $0)
=======
source ../file-processing-start.sh $(basename $0)
>>>>>>> a181d103409fe8556bb43d2b0efe53a8a29f6cea

mkdir -v build
cd build

../configure                   \
    --prefix=/usr              \
    --build=$(../config.guess) \
    --host=$LFS_TGT            \
    --disable-nls              \
    --enable-shared            \
    --disable-werror           \
    --enable-64-bit-bfd

make

make DESTDIR=$LFS install -j1
install -vm755 libctf/.libs/libctf.so.0.0.0 $LFS/usr/lib

<<<<<<< HEAD
source build_scripts/file-cleanup.sh $(basename $0)
=======
source ../file-cleanup.sh $(basename $0)
>>>>>>> a181d103409fe8556bb43d2b0efe53a8a29f6cea
