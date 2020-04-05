#!/bin/sh

if [ "$1" != "" ]; then
	version=$1
else
	version='4.2.0'
fi

cd /usr/local/src/opencv-$version/build
make install

echo "/usr/local/opencv-$version/lib" >/etc/ld.so.conf.d/opencv-$version.conf
ldconfig

sed -i -e "/PYTHONPATH=\/usr\/local\/opencv-/d" /root/.bashrc
echo "export PYTHONPATH=/usr/local/opencv-$version/lib/python3.5/dist-packages" >>/root/.bashrc
