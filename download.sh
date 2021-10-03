#!/bin/bash


for i in {0..78} 
do 
  NAME=`jq -r ".package[$i].name" packages.json`
  VERSION=` jq -r ".package[$i].version" packages.json`
  URL=` jq -r ".package[$i].url" packages.json | sed s/@/$VERSION/g`
  MD5=` jq -r ".package[$i].md5" packages.json`

  CACHEFILE="$(basename "$URL")"
  
  echo NAME $NAME
  echo VERSION $VERSION
  echo URL $URL
  echo MD5 $MD5
  echo CACHEFILE $CACHEFILE
  echo "========================================="
done
