<<<<<<< HEAD
source build_scripts/file-processing-start.sh $(basename $0)
=======
source ../file-processing-start.sh $(basename $0)
>>>>>>> a181d103409fe8556bb43d2b0efe53a8a29f6cea


mkdir mpfr gmp mpc
tar xvf ../mpfr-*.tar.xz -C ./mpfr  --strip-component=1
tar xvf ../gmp-*.tar.xz -C ./gmp    --strip-component=1 
tar xvf ../mpc-*.tar.gz -C ./mpc    --strip-component=1

case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
  ;;
esac

mkdir -v build
cd build

mkdir -pv $LFS_TGT/libgcc
ln -s ../../../libgcc/gthr-posix.h $LFS_TGT/libgcc/gthr-default.h

../configure                                       \
    --build=$(../config.guess)                     \
    --host=$LFS_TGT                                \
    --prefix=/usr                                  \
    CC_FOR_TARGET=$LFS_TGT-gcc                     \
    --with-build-sysroot=$LFS                      \
    --enable-initfini-array                        \
    --disable-nls                                  \
    --disable-multilib                             \
    --disable-decimal-float                        \
    --disable-libatomic                            \
    --disable-libgomp                              \
    --disable-libquadmath                          \
    --disable-libssp                               \
    --disable-libvtv                               \
    --disable-libstdcxx                            \
    --enable-languages=c,c++

make 

make DESTDIR=$LFS install

ln -sv gcc $LFS/usr/bin/cc

<<<<<<< HEAD
source build_scripts/file-cleanup.sh $(basename $0)
=======
source ../file-cleanup.sh $(basename $0)
>>>>>>> a181d103409fe8556bb43d2b0efe53a8a29f6cea
