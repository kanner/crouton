#!/bin/bash

set -ex

PREFIX="sudo"

home="$(realpath ~)"
media="/media/removable/"
sd1=$media"sdmain/"
sd2=$media"sdbackup/"
chroot_path1=$sd1"chroots/"
chroot_path2="/home/chroots/"

# 1. create second chroot path (on internal ssd)
$PREFIX mkdir $chroot_path2

# 2. create "home"-links to SD-card partitions
ln -s $sd2 $home"/"
ln -s $sd1 $home"/"

# 3. create chroot-link to external chroot path
$PREFIX ln -s $chroot_path1 /usr/local/

# 4. copy and extract crouton to ~
cp $sd2"distrib/crouton.tar.gz" ~
cd ~ && tar xzvf crouton.tar.gz
rm ~/crouton.tar.gz

# 5. install chroot bin
cd ~/crouton && $PREFIX sh -e crouton -b

# 6.0 relink chroot-link to internal chroot path
$PREFIX unlink /usr/local/chroots
$PREFIX ln -s $chroot_path2 /usr/local/

# 6.1 recover Ubuntu chroot to internal chroot path
#$PREFIX edit-chroot -r -f $sd2"chroots-backup/ubuntu1404_unity-enc.tar" ubuntu1404_unity-enc

# 6.2 install chroot bin (if new arrived)
cd ~/crouton && $PREFIX sh -e crouton -b

# 7. copy chroot-switch.sh to ~
cp $sd2"distrib/chroot-switch.sh" ~

# 8. configure verified boot and disable usb booting
#$PREFIX crossystem dev_boot_usb=0 dev_boot_signed_only=1

# 9. install development environment to /usr/local
#1. $PREFIX dev_install
#2. $PREFIX su - <<-"EOF"
#	dev_install
#	exit
#EOF

# need to use "sudo su -" and then "dev_install", or just use VT-terminal

exit 0
