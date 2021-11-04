#!/bin/bash
echo "Dist root: ${DIST_ROOT}"
echo "LFS: ${LFS:?}"
CHARPTER=$1
PACKAGE=$2

if ! test $(whoami) = distbuild; then
  echo "Must run as distbuild"
  exit 1
fi


PACKAGE_INFOS=($(cat ./packages.json | jq -r ".package[] | select(.name| test(\"$PACKAGE$\")?) | .version, .url"))

  export VERSION=${PACKAGE_INFOS[0]}
  URL=`echo ${PACKAGE_INFOS[1]} | sed s/@/$VERSION/g`
  CACHEFILE="$(basename "$URL")"
  DIRNAME="$(echo "$CACHEFILE" | sed 's/\(.*\)\.tar\..*/\1/')"

  mkdir -pv $DIRNAME

  echo "Extracting $CACHEFILE ..."
  tar -xf $CACHEFILE -C $DIRNAME

  pushd "$DIRNAME"

    if [ "$(ls -1A | wc -l)" == "1" ]; then
      mv $(ls -1A)/* ./
    fi
   
    echo "Compiling $PACKAGE ..."
    sleep 5
    
    mkdir -pv "../log/charpter$CHARPTER/"
    
    if ! source "../charpter$CHARPTER/$PACKAGE.sh" 2>&1 | tee "../log/charpter$CHARPTER/$PACKAGE.log" ; then  
      echo "Compiling $PACKAGE failed!!"
      popd
      exit 1
    fi
  
  echo "$PACKAGE Done"
  popd
