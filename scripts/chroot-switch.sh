#!/bin/bash

set -ex

PREFIX="sudo"

chroot_path="/usr/local/chroots"
chroot_path1="/media/removable/sdmain/chroots/"
chroot_path2="/home/chroots/"
chroot_path_new=""

if [ "$(realpath "$chroot_path")/" = $chroot_path1 ]; then
	chroot_path_new="$chroot_path2"
elif [ "$(realpath "$chroot_path")/" = $chroot_path2 ]; then
	chroot_path_new="$chroot_path1"
else
	echo "Error switching chroot: not correct target link"
	exit 1
fi

$PREFIX unlink $chroot_path
$PREFIX ln -s $chroot_path_new $chroot_path
exit 0
