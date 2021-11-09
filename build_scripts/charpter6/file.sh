source $DIST_ROOT/LFS-instalation/build_scripts/file-processing-start.sh $(basename $0)

mkdir build
pushd build
  ../configure --disable-bzlib      \
               --disable-libseccomp \
               --disable-xzlib      \
               --disable-zlib
  make
popd

./configure --prefix=/usr --host=$LFS_TGT --build=$(./config.guess)

make FILE_COMPILE=$(pwd)/build/src/file

make DESTDIR=$LFS install

source $DIST_ROOT/LFS-instalation/build_scripts/file-cleanup.sh $(basename $0) 
