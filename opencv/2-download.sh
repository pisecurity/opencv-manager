#!/bin/sh

if [ "$1" != "" ]; then
	version=$1
else
	version='4.2.0'
fi

base=`echo $version |cut -d- -f1`
cd /usr/local/src

if [ ! -f opencv-$version.tar.gz ]; then
	wget https://github.com/opencv/opencv/archive/$version.tar.gz
	mv $version.tar.gz opencv-$version.tar.gz
fi

if [ ! -f opencv-contrib-$base.tar.gz ]; then
	wget https://github.com/opencv/opencv_contrib/archive/$base.tar.gz
	mv $base.tar.gz opencv-contrib-$base.tar.gz
fi
