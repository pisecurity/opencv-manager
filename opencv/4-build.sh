#!/bin/sh

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

cd /usr/local/src/opencv-$version/build
cmake \
	-DWITH_TBB=ON \
	-DWITH_GDAL=ON \
	-DENABLE_NEON=$arm \
	-DENABLE_VFPV3=$arm \
	-DBUILD_opencv_java=OFF \
	-DENABLE_PRECOMPILED_HEADERS=OFF \
	-DCMAKE_INSTALL_PREFIX=/usr/local/opencv-$version \
	-DOPENCV_ENABLE_NONFREE=ON \
	-DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules \
	..

make -k -j2

# building cv2.cpp.o for python modules probably failed above - let's
# try once again in single process (so all memory will be available to it)
make
