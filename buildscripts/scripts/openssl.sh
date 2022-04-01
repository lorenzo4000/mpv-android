#!/bin/bash -e

. ../../include/path.sh

build=_build$ndk_suffix

if [ "$1" == "build" ]; then
	true
elif [ "$1" == "clean" ]; then
	rm -rf $build
	exit 0
else
	exit 255
fi

mkdir -p $build
cd $build

./../Configure android-arm -D__ANDROID_API__=21 --prefix=$prefix_dir --openssldir=$prefix_dir/ssl
make
make install
