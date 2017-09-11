#!/bin/sh

build_version=3
package_name=ctemplate-android

current_dir="`pwd`"

if test "x$ANDROID_NDK" = x ; then
  echo should set ANDROID_NDK before running this script.
  exit 1
fi

# Includes
cd "$current_dir"
tar xzf include.tar.gz
mkdir -p "$current_dir/$package_name-$build_version/include"
cp -r include/ctemplate "$current_dir/$package_name-$build_version/include"

cd "$current_dir/jni"
$ANDROID_NDK/ndk-build

TARGET_ARCH_ABI=armeabi-v7a
mkdir -p "$current_dir/$package_name-$build_version/libs/$TARGET_ARCH_ABI"
cp "$current_dir/obj/local/$TARGET_ARCH_ABI/libctemplate.a" "$current_dir/$package_name-$build_version/libs/$TARGET_ARCH_ABI"

cd "$current_dir"
