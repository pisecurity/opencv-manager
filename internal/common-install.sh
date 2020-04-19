#!/bin/bash

if [ "$1" != "" ]; then
	version=$1
else
	version='4.3.0'
fi

if [ ! -d /usr/local/opencv-$version ]; then
	echo "opencv-$version not found"
	exit 0
fi


echo "/usr/local/opencv-$version/lib" >/etc/ld.so.conf.d/opencv-$version.conf
ldconfig


# remove symlinks, but keep real files (probably installed different way)
if [ -h /usr/lib/pkgconfig/opencv.pc ]; then
	rm -f /usr/lib/pkgconfig/opencv.pc
fi
if [ ! -f /usr/lib/pkgconfig/opencv.pc ]; then
	ln -s /usr/local/opencv-$version/lib/pkgconfig/opencv.pc /usr/lib/pkgconfig
fi


# Python 2.x support
mkdir -p /usr/local/lib/python2.7/dist-packages
if [ -h /usr/local/lib/python2.7/dist-packages/cv2.so ]; then
	rm -f /usr/local/lib/python2.7/dist-packages/cv2.so
fi
if [ ! -f /usr/local/lib/python2.7/dist-packages/cv2.so ]; then
	ln -s /usr/local/opencv-$version/lib/python2.7/dist-packages/cv2.so /usr/local/lib/python2.7/dist-packages
fi


# Python 3.x support
if [ "`lsb_release -cs`" = "buster" ] && [[ $version == "3.4."* ]]; then
	:
else
	sed -i -e "/PYTHONPATH=\/usr\/local\/opencv-/d" /root/.bashrc
	echo "export PYTHONPATH=/usr/local/opencv-$version/lib/python3.5/dist-packages" >>/root/.bashrc
fi
