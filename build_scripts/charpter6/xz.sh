source ../file-processing-start.sh $1

./configure --prefix=/usr                     \
            --host=$LFS_TGT                   \
            --build=$(build-aux/config.guess) \
            --disable-static                  \
            --docdir=/usr/share/doc/xz-5.2.5

make 

make DESTDIR=$LFS install

source ../file-cleanup.sh $1
