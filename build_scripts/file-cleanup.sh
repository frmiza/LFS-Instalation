FILE=$1

echo 
echo "Clean up..."
echo 
sleep 1

cd $LFS/sources
DIR=$(echo $FILE | sed 's/\(.*\).tar\..*/\1/')
rm -rf $DIR

echo 
echo "Done"
echo 




