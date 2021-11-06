#!/bin/bash
echo "LFS: ${LFS:?}"

# intermediate cross compiling
mkdir -pv $LFS/sources # download tarballs here 
chmod -v a+wt $LFS/sources

# basic linux structure
mkdir -pv $LFS/{boot,etc,var,usr/{bin,lib,sbin},tools}

for i in bin lib sbin; do
  ln -sv usr/$i $LFS/$i
done

case $(uname -m) in # check if we are compiling to a x86_64 machine
  x86_64) mkdir -pv $LFS/lib64 ;;
esac


## DONWLOAD SECTION
sudo cp -rf *.sh packages.json charpter* "$LFS/sources"
cd "$LFS/sources"

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

cat > ~/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
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
