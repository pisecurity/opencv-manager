#!/bin/bash

if [ "$1" != "" ]; then
	version=$1
else
	version='4.2.0'
fi

if [ "`uname -m`" = "armv7l" ]; then
	arm="ON"
else
	arm="OFF"
fi

dt1=`date +%Y%m%d-%H%M`
release=`lsb_release -cs`
if [ "$release" = "buster" ] && [[ $version == "3.4."* ]]; then
	pyth="OFF"
else
	pyth="ON"
fi

echo "############################################################"
echo "# Building opencv-$version on $release - init at $dt1"
echo "############################################################"

cd /usr/local/src/opencv-$version/build
cmake \
	-DWITH_TBB=ON \
	-DWITH_GDAL=ON \
	-DENABLE_NEON=$arm \
	-DENABLE_VFPV3=$arm \
	-DENABLE_PRECOMPILED_HEADERS=OFF \
	-DBUILD_opencv_java=OFF \
	-DBUILD_opencv_python=$pyth \
	-DCMAKE_INSTALL_PREFIX=/usr/local/opencv-$version \
	-DOPENCV_ENABLE_NONFREE=ON \
	-DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules \
	..

echo "############################################################"
echo "# Building opencv-$version on $release - first pass"
echo "############################################################"

make -k -j2

if [ "$pyth" = "ON" ]; then
	echo "############################################################"
	echo "# Building opencv-$version on $release - second pass"
	echo "############################################################"

	# building cv2.cpp.o for python modules probably failed above - let's
	# try once again in single process (so all memory will be available to it)
	make
fi

dt2=`date +%Y%m%d-%H%M`
echo "############################################################"
echo "# Building opencv-$version on $release - finished"
echo "# Build lasted from $dt1 to $dt2"
echo "############################################################"
