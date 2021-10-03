#!/bin/bash


for i in {0..78} 
do 
  NAME=`jq -r ".package[$i].name" packages.json`
  VERSION=` jq -r ".package[$i].version" packages.json`
  URL=` jq -r ".package[$i].url" packages.json | sed s/@/$VERSION/g`
  MD5=` jq -r ".package[$i].md5" packages.json`

  CACHEFILE="$(basename "$URL")"

  if [ ! -f "$CACHEFILE" ]; then

    echo "Downloading $URL"
    wget "$URL"
    if ! echo $MD5 $CACHEFILE | md5sum -c > /dev/null; then
      rm -f $CACHEFILE
      echo "faliled!! MD5sun of $CACHEFILE mismatch"
      exit 1
    fi
  fi

done
