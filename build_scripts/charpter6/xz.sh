source build_scripts/file-processing-start.sh $(basename $0)

./configure --prefix=/usr                     \
            --host=$LFS_TGT                   \
            --build=$(build-aux/config.guess) \
            --disable-static                  \
            --docdir=/usr/share/doc/xz-5.2.5

make 

make DESTDIR=$LFS install

source build_scripts/file-cleanup.sh $(basename $0)
