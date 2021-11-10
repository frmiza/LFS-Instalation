source $DIST_ROOT/LFS-instalation/build_scripts/file-processing-start.sh $(basename $0)

./configure --disable-shared
make 
cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} /usr/bin


source $DIST_ROOT/LFS-instalation/build_scripts/file-cleanup.sh $(basename $0)
