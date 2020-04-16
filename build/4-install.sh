#!/bin/sh

if [ "$1" != "" ]; then
	version=$1
else
	version='4.3.0'
fi

prevdir=`dirname $0`
if [ "$prevdir" = "." ]; then prevdir=`pwd`; fi
if [ "$prevdir" = ".." ]; then echo "run this script from its directory"; exit 1; fi


cd /usr/local/src/opencv-$version/build
make install

$prevdir/../internal/common-install.sh $version
