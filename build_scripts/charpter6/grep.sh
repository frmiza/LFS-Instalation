<<<<<<< HEAD
source build_scripts/file-processing-start.sh $(basename $0)
=======
source ../file-processing-start.sh $(basename $0)
>>>>>>> a181d103409fe8556bb43d2b0efe53a8a29f6cea

./configure --prefix=/usr   \
            --host=$LFS_TGT

make 

make DESTDIR=$LFS install

<<<<<<< HEAD
source build_scripts/file-cleanup.sh $(basename $0)
=======
source ../file-cleanup.sh $(basename $0)
>>>>>>> a181d103409fe8556bb43d2b0efe53a8a29f6cea
