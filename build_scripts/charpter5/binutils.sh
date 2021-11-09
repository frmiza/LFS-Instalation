source $DIST_ROOT/LFS-instalation/build_scripts/file-processing-start.sh $(basename $0)

mkdir -pv build
cd build

../configure --prefix=$LFS/tools \
  --with-sysroot=$LFS \
  --target=$LFS_TGT   \
  --disable-nls       \
  --disable-werror    

make && make install 

source $DIST_ROOT/LFS-instalation/build_scripts/file-cleanup.sh $(basename $0)
