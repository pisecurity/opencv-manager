#!/bin/sh

if [ "$1" != "" ]; then
	version=$1
else
	version='4.3.0'
fi

release=`lsb_release -cs`
arch=`uname -m`

if [ -d /usr/local/opencv-$version ] && [ ! -f /usr/local/opencv-$version-$release-$arch.tar.gz ]; then
	cd /usr/local
	tar czvf opencv-$version-$release-$arch.tar.gz opencv-$version
fi
