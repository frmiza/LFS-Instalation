#!/bin/bash
echo "LFS: ${LFS:?}"
echo "DIST_ROOT: ${DIST_ROOT:?}"

if ! test $(whoami) == "distbuild" ; then
	echo "must run as distbuild"
	exit -1
fi

## CHARPTER 5

mkdir -pv $LFS/sources/log/charpter5
for package in binutils gcc linux-headers glibc libstdc++ ; do
  bash -e build_scripts/charpter5/${package}.sh | tee $LFS/sources/log/charpter5/${package}.log
done

## CHARPTER 6

mkdir -pv $LFS/sources/log/charpter6
for package in m4 ncurses bash coreutils diffutils file findutils gawk grep gzip make patch sed tar xz binutils gcc ; do
  bash -e build_scripts/charpter6/${package}.sh | tee $LFS/sources/log/charpter6/${package}.log
done

## CHARPTER 7

sudo -E ./build_scripts/charpter7/build-chroot.sh

