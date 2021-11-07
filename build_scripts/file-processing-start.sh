FILE=$1

echo 
echo "Processing $FILE"
echo 
sleep 1

cd $LFS/sources
tar -xf $FILE
DIR=$(echo $FILE | sed 's/\(.*\).tar\..*/\1/')
cd $DIR

