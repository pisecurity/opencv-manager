#!/bin/sh

apt-get update

# Build tools:
apt-get install build-essential cmake make gcc g++ yasm unzip wget

# Media I/O:
apt-get install zlib1g-dev libjpeg-dev libwebp-dev libpng-dev libtiff5-dev libjasper-dev libopenexr-dev libgdal-dev

# Video I/O:
apt-get install libdc1394-22-dev libavcodec-dev libavformat-dev libavresample-dev libswscale-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev libopencore-amrnb-dev libopencore-amrwb-dev libv4l-dev

# Parallelism and linear algebra libraries:
apt-get install libtbb-dev libeigen3-dev liblapacke-dev libatlas-base-dev

# OCR and fonts support:
apt-get install tesseract-ocr tesseract-ocr-pol libharfbuzz-dev libfreetype6-dev

# Python interface:
apt-get install python-dev python-numpy python3-dev python3-numpy
