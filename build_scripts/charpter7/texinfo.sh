source /dist/LFS-instalation/build_scripts/file-processing-start.sh $(basename $0)

sed -e 's/__attribute_nonnull__/__nonnull/' \
    -i gnulib/lib/malloc/dynarray-skeleton.c

./configure --prefix=/usr

make && make install 

source /dist/LFS-instalation/build_scripts/file-cleanup.sh $(basename $0)
