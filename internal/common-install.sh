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


# Python 2.x support
mkdir -p /usr/local/lib/python2.7/dist-packages
ln -s /usr/local/opencv-$version/lib/python2.7/dist-packages/cv2.so /usr/local/lib/python2.7/dist-packages


# Python 3.x support
if [ "`lsb_release -cs`" = "buster" ] && [[ $version == "3.4."* ]]; then
	:
else
	sed -i -e "/PYTHONPATH=\/usr\/local\/opencv-/d" /root/.bashrc
	echo "export PYTHONPATH=/usr/local/opencv-$version/lib/python3.5/dist-packages" >>/root/.bashrc
fi