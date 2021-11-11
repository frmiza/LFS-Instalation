FILE=$(echo $1 | sed 's/\..*//')

echo 
echo "Processing $FILE"
echo 
sleep 1

cd $LFS/sources
TARBALL=$(ls $FILE-*.tar.*)
tar xvvf $TARBALL

DIR=$(echo $TARBALL | sed 's/\(.*\).tar\..*/\1/')
cd $DIR
