<<<<<<< HEAD
source build_scripts/file-processing-start.sh $(basename $0)
=======
source ../file-processing-start.sh $(basename $0)
>>>>>>> a181d103409fe8556bb43d2b0efe53a8a29f6cea

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

<<<<<<< HEAD
source build_scripts/file-cleanup.sh $(basename $0) 
=======
source ../file-cleanup.sh $(basename $0) 
>>>>>>> a181d103409fe8556bb43d2b0efe53a8a29f6cea
