<<<<<<< HEAD
source build_scripts/file-processing-start.sh $(basename $0)
=======
source ../file-processing-start.sh $(basename $0)
>>>>>>> a181d103409fe8556bb43d2b0efe53a8a29f6cea

./configure --prefix=/usr                   \
            --build=$(support/config.guess) \
            --host=$LFS_TGT                 \
            --without-bash-malloc
make

make DESTDIR=$LFS install

ln -sv bash $LFS/bin/sh

<<<<<<< HEAD
source build_scripts/file-cleanup.sh $(basename $0)
=======
source ../file-cleanup.sh $(basename $0)
>>>>>>> a181d103409fe8556bb43d2b0efe53a8a29f6cea
