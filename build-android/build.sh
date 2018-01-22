#!/bin/sh

build_version=3
package_name=ctemplate-android

if ! which ndk-build > /dev/null ; then
  echo Android NDK should be installed and ndk-build in PATH
  exit 1
fi

pushd "$(realpath $(dirname $0))"
    # Includes
    tar xzf include.tar.gz
    mkdir -p "$package_name-$build_version/include"
    cp -r include/ctemplate "$package_name-$build_version/include"

    ndk-build -j "$@"

    TARGET_ARCH_ABI=armeabi-v7a
    SRC=${NDK_OUT:-obj}/local/$TARGET_ARCH_ABI/libctemplate.a
    DST=$package_name-$build_version/libs/$TARGET_ARCH_ABI

    mkdir -p "$DST"
    cp "$SRC" "$DST"
popd
