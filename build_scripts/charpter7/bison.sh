source $DIST_ROOT/LFS-instalation/build_scripts/file-processing-start.sh $(basename $0)

./configure --prefix=/usr \
            --docdir=/usr/share/doc/bison-3.7.6

make && make install

source $DIST_ROOT/LFS-instalation/build_scripts/file-cleanup.sh $(basename $0)

