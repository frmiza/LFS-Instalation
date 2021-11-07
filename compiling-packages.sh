#!/bin/bash
echo "LFS: ${LFS:?}"

if ! test $(whoami) == "distbuild" ; then
	echo "must run as distbuild"
	exit -1
fi

mkdir -pv $LFS/sources/log/charpter5

bash -e charpter5/binutils.sh | tee $LFS/sources/log/charpter5/binutils.log
bash -e charpter5/gcc.sh | tee $LFS/sources/log/charpter5/gcc.log
bash -e charpter5/linux-headers.sh | tee $LFS/sources/log/charpter5/linux-headers.log
bash -e charpter5/glibc.sh | tee $LFS/sources/log/charpter5/glibc.log
