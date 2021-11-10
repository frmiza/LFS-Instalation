echo "Mounting ${LFS:?}"
echo "Binding ${DIST_ROOT:?}"


umount $LFS/dist 
umount $LFS/run
umount $LFS/sys
umount $LFS/proc
umount $LFS/dev/pts
umoun $LFS/dev
