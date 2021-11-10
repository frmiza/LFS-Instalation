set -e
echo "Preparing Chroot ${LFS:?}"
echo ""

chown -R root:root $LFS/{usr,lib,var,etc,bin,sbin,tools}

case $(uname -m) in
  x86_64) chown -R root:root $LFS/lib64 ;;
esac

mkdir -pv $LFS/{dev,proc,sys,run}

if ! test -c $LFS/dev/console; then
  mknod -m 600 $LFS/dev/console c 5 1
  mknod -m 666 $LFS/dev/null c 1 3
fi

bash -e $DIST_ROOT/LFS-instalation/build_scripts/mount-vfs.sh

cat > $LFS/etc/passwd << "EOF"
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/dev/null:/bin/false
daemon:x:6:6:Daemon User:/dev/null:/bin/false
messagebus:x:18:18:D-Bus Message Daemon User:/run/dbus:/bin/false
uuidd:x:80:80:UUID Generation Daemon User:/dev/null:/bin/false
nobody:x:99:99:Unprivileged User:/dev/null:/bin/false
EOF

cat > $LFS/etc/group << "EOF"
root:x:0:
bin:x:1:daemon
sys:x:2:
kmem:x:3:
tape:x:4:
tty:x:5:
daemon:x:6:
floppy:x:7:
disk:x:8:
lp:x:9:
dialout:x:10:
audio:x:11:
video:x:12:
utmp:x:13:
usb:x:14:
cdrom:x:15:
adm:x:16:
messagebus:x:18:
input:x:24:
mail:x:34:
kvm:x:61:
uuidd:x:80:
wheel:x:97:
nogroup:x:99:
users:x:999:
EOF

chroot "$LFS" /usr/bin/env -i   \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin     \
    MAKEFLAGS='-j4'             \
    CFLAGS='-O2 -march=native -pipe'   \
    CXXFLAGS='-O2 -march=native -pipe' \
    /dist/LFS-instalation/build_scripts/charpter7/finish-chroot.sh


bash -e $DIST_ROOT/LFS-instalation/build_scripts/umount-vfs.sh
