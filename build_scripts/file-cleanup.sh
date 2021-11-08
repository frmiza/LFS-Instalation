FILE=$(echo $1 | sed 's/\..*//')

echo 
echo "Clean up..."
echo 
sleep 1

cd $LFS/sources
rm -rf ${FILE}-*/

echo 
echo "Done"
echo 




