#!/bin/bash

sudo mkdir -pv /mnt/lfs

export LFS=/mnt/lfs
export LFS_TGT=x86_64-lfs-linux-gnu
export LFS_DISK=/dev/sdc

if ! grep -q "$LFS" /proc/mounts; then
  source setupdisk.sh "$LFS_DISK" # if LFS is not mount yet 
  sudo mount "${LFS_DISK}2" "$LFS" 
  sudo chown -v $USER "$LFS" # in the LFS book they create a few directories and chenge the owner for each one, chenge the owner of the whole mount point to $USER will work, and we dont need use "sudo" to create directories and files anymore
fi

# intermediate cross compiling
mkdir -pv $LFS/tools # cross compiling sit here
mkdir -pv $LFS/sources # download tarballs here 

# basic linux structure
mkdir -pv $LFS/{boot,etc,bin,lib,sbin,usr,var}

case $(uname -m) in # check if we are compiling to a x86_64 machine
  x86_64) mkdir -pv $LFS/lib64 ;;
esac
