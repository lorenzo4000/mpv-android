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

cpu=armeabi-v7a

cmake \
	-DCMAKE_INSTALL_PREFIX=/${prefix_dir}/ \
	-DCMAKE_INCLUDE_PATH=${prefix_dir}/include/ \
	-DWITH_INTERNAL_DOC=OFF \
	-DWITH_GSSAPI=OFF \
	-DWITH_NACL=OFF \
	-DWITH_EXAMPLES=OFF \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_TOOLCHAIN_FILE=${NDK_TOOLCHAIN_FILE} \
	-DANDROID_NDK=${NDK_DIR} \
	-DANDROID_PLATFORM=21 \
	-DANDROID_ABI=${cpu} \
	-DBUILD_STATIC_LIB=1 \
	-DBUILT_LIBS_DIR=${prefix_dir}/lib/ \
	-DOPENSSL_SSL_LIBRARY=${prefix_dir}/lib/libssl.a \
	-DOPENSSL_CRYPTO_LIBRARY=${prefix_dir}/lib/libcrypto.a \
	-DOPENSSL_INCLUDE_DIR=${prefix_dir}/include/ \
	-DWITH_ZLIB=1 \
	-DWITH_SERVER=1 \
	-DWITH_SFTP=1 \
	../
	
cmake --build .
make install
