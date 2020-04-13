#!/bin/sh

if [ "$1" != "" ]; then
	version=$1
else
	version='4.2.0'
fi

release=`lsb_release -cs`
arch=`uname -m`
if [ "$arch" = "x86_64" ]; then arch="amd64"; fi

link="https://github.com/fajneit/opencv-build-scripts/releases/download/$version/opencv-$version-nox+contrib+nonfree-$release-$arch.tar.gz"
file=`basename $link`


prevdir=`dirname $0`
if [ "$prevdir" = "." ]; then prevdir=`pwd`; fi
if [ "$prevdir" = ".." ]; then echo "run this script from its directory"; exit 1; fi


cd /usr/local

if [ ! -f $file ]; then
	wget $link
fi

tar xzvf $file

$prevdir/common-install.sh
