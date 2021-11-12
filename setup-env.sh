#!/bin/bash
echo "LFS: ${LFS:?}"
echo "DIST_ROOT: ${DIST_ROOT:?}"

chmod 755 $LFS

# intermediate cross compiling
mkdir -pv $LFS/sources # download tarballs here 
chmod -v a+wt $LFS/sources

# basic linux structure
mkdir -pv $LFS/{boot,etc,var,usr/{bin,lib,sbin},tools}

ln -sv usr/bin $LFS/bin
ln -sv usr/lib $LFS/lib
ln -sv usr/sbin $LFS/sbin

case $(uname -m) in # check if we are compiling to a x86_64 machine
  x86_64) mkdir -pv $LFS/lib64 ;;
esac


## DONWLOAD SECTION
cp -rf ../LFS-instalation $DIST_ROOT
cp -rf ./* $LFS/sources

cd $LFS/sources
source packages-download.sh

if ! test $(id -u distbuild); then

  groupadd distbuild
  useradd -s /bin/bash -g distbuild -m -k /dev/null distbuild
  passwd distbuild

  chown -v distbuild $LFS/{boot,usr{,/*},lib,var,etc,bin,sbin,tools,sources,sources/*}
  case $(uname -m) in # check if we are compiling to a x86_64 machine
    x86_64) chown -v distbuild $LFS/lib64 ;;
  esac
  
  dbhome=$(eval echo "~distbuild")

cat > $dbhome/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

cat > $dbhome/.bashrc << EOF
set +h
umask 022
LFS=$(echo $LFS)
export DIST_ROOT=$(echo $DIST_ROOT)
EOF

cat > $dbhome/.bashrc << "EOF"
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
MAKEFLAGS="-j4"
EOF

fi
