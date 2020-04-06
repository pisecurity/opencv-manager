#!/bin/sh

if [ "$1" != "" ]; then
	version=$1
else
	version='4.2.0'
fi

base=`echo $version |cut -d- -f1`
cd /usr/local/src

if [ -f opencv-$version.tar.gz ] && [ -f opencv-contrib-$base.tar.gz ]; then
	tar xzvf opencv-$version.tar.gz
	tar xzvf opencv-contrib-$base.tar.gz
	mv opencv_contrib-$base opencv_contrib
	mv opencv_contrib opencv-$version
	mkdir opencv-$version/build
fi
