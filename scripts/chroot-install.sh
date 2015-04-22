#!/bin/bash

CROUTON_BIN="$(realpath ~)/crouton/crouton"
CRYPTO=""
TARGETS=""
RELEASE=""
NAME=""

CHROOT_BASE="audio,cli-extra,core"
DM_GTK="gtk-extra"
DM_X11="extension,keyboard,x11,xorg"
DM_E17="e17,$DM_GTK,$DM_X11"
DM_KDE="kde,kde-desktop,$DM_X11"
DM_UNITY="unity,unity-desktop,$DM_GTK,$DM_X11"
DM_XFCE4="xfce,xfce-desktop,$DM_GTK,$DM_X11"

E17="$CHROOT_BASE,$DM_E17"
KDE="$CHROOT_BASE,$DM_KDE"
UNITY="$CHROOT_BASE,$DM_UNITY"
XFCE4="$CHROOT_BASE,$DM_XFCE4"

if [ "$1" = "" ] || [ "$2" = "" ] || [ "$3" = "" ]; then
	echo "script for preparing chroot-kits [ch-rootkits :)]";
	echo "";
	echo "usage:";
	echo "	$0 enc e17|kde|unity|xfce4 trusty|jessie|... CHROOT_NAME";
	exit 1;
fi

if [ "$1" = "enc" ]; then
	CRYPTO="-e"
fi

if [ "$2" = "e17" ]; then
	TARGETS="$E17"
elif [ "$2" = "kde" ]; then
	TARGETS="$KDE"
elif [ "$2" = "unity" ]; then
	TARGETS="$UNITY"
elif [ "$2" = "xfce4" ]; then
	TARGETS="$XFCE4"
else
	echo "Error: not supported TARGET kit!"
	exit 1;
fi

if [ "$3" = "trusty" ]; then
	RELEASE="trusty"
elif [ "$3" = "jessie" ]; then
	RELEASE="jessie"
else
	echo "Error: not supported Linux distribution release!"
	exit 1;
fi

if [ "$4" = "" ]; then
	NAME="${RELEASE}_$2"
else
	NAME="$4"
fi

sudo sh -e $CROUTON_BIN $CRYPTO -t $TARGETS -r $RELEASE -n $NAME
#echo "sudo sh -e $CROUTON_BIN $CRYPTO -t $TARGETS -r $RELEASE -n $NAME"
