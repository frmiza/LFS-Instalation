source ../file-processing-start.sh $1

make mrproper

make headers
find usr/include -name '.*' -delete
rm usr/include/Makefile
cp -rv usr/include $LFS/usr

source ../file-cleanup.sh $1
