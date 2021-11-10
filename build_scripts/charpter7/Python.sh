source $DIST_ROOT/LFS-instalation/build_scripts/file-processing-start.sh $(basename $0)

./configure --prefix=/usr   \
            --enable-shared \
            --without-ensurepip

make && make install

source $DIST_ROOT/LFS-instalation/build_scripts/file-cleanup.sh $(basename $0)
