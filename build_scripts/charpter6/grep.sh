source ../file-processing-start.sh $1

./configure --prefix=/usr   \
            --host=$LFS_TGT

make 

make DESTDIR=$LFS install

source ../file-cleanup.sh $1
