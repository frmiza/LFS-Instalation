#!/bin/bash
echo "Mounting ${LFS:?}"
echo "Binding ${DIST_ROOT:?}"

set -e
echo "Preparing Chroot ${LFS:?}"
echo ""

chown -R root:root $LFS/{usr,lib,var,etc,bin,sbin,tools}

case $(uname -m) in
  x86_64) chown -R root:root $LFS/lib64 ;;
esac

mkdir -pv $LFS/{dev,proc,sys,run,dist}

if ! test -c $LFS/dev/console; then
  mknod -m 600 $LFS/dev/console c 5 1
  mknod -m 666 $LFS/dev/null c 1 3
fi

# Mount points
mount -v --bind /dev $LFS/dev
mount -v --bind /dev/pts $LFS/dev/pts
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run

if [ -h $LFS/dev/shm ]; then
  mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi

mount -v --bind $DIST_ROOT/ $LFS/dist 

# ENTER THE CHROOT
chroot "$LFS" /usr/bin/env -i   \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin     \
    MAKEFLAGS='-j4'             \
    CFLAGS='-O2 -march=native -pipe'   \
    CXXFLAGS='-O2 -march=native -pipe' \
    /bin/bash --login +h -c "/dist/LFS-instalation/build_scripts/charpter7/finish-chroot.sh"


echo "Unmounting ${LFS:?}"
echo "UnBinding ${DIST_ROOT:?}"

umount -v $LFS/dist 
umount -v $LFS/run
umount -v $LFS/sys
umount -v $LFS/proc
umount -v $LFS/dev/pts
umount -v $LFS/dev
