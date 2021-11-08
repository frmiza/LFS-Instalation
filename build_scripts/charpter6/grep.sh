source ../file-processing-start.sh $(basename $0)

./configure --prefix=/usr   \
            --host=$LFS_TGT

make 

make DESTDIR=$LFS install

source ../file-cleanup.sh $(basename $0)
