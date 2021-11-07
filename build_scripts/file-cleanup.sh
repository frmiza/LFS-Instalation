FILE=$(echo $1 | sed 's/\..*//')

echo 
echo "Clean up..."
echo 
sleep 1

cd $LFS/sources
TARBALL=$(ls $FILE-*.tar.xz)
DIR=$(echo $TARBALL | sed 's/\(.*\).tar\..*/\1/')

rm -rf $DIR

echo 
echo "Done"
echo 




