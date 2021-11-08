source ../file-processing-start.sh $(basename $0)

./configure --prefix=/usr                   \
            --build=$(support/config.guess) \
            --host=$LFS_TGT                 \
            --without-bash-malloc
make

make DESTDIR=$LFS install

ln -sv bash $LFS/bin/sh

source ../file-cleanup.sh $(basename $0)
