#!/bin/sh

build_version=1
ANDROID_PLATFORM=android-21
openssl_build_version=1
cyrus_sasl_build_version=1
archs="armeabi armeabi-v7a x86 x86_64"
package_name=ctemplate-android

current_dir="`pwd`"

if test "x$ANDROID_NDK" = x ; then
  echo should set ANDROID_NDK before running this script.
  exit 1
fi

function build {
  rm -rf "$current_dir/obj"

  cd "$current_dir/jni"
  $ANDROID_NDK/ndk-build TARGET_PLATFORM=$ANDROID_PLATFORM TARGET_ARCH_ABI=$TARGET_ARCH_ABI

  mkdir -p "$current_dir/$package_name-$build_version/libs/$TARGET_ARCH_ABI"
  cp "$current_dir/obj/local/$TARGET_ARCH_ABI/libctemplate.a" "$current_dir/$package_name-$build_version/libs/$TARGET_ARCH_ABI"
  rm -rf "$current_dir/src"
}

cd "$current_dir/.."
./autogen.sh
make prepare

# Includes
cd "$current_dir"
tar xzf include.tar.gz
mkdir -p "$current_dir/$package_name-$build_version/include"
cp -r include/ctemplate "$current_dir/$package_name-$build_version/include"

# Start building.
for arch in $archs ; do
  TARGET_ARCH_ABI=$arch
  build
done

cd "$current_dir"
zip -qry "$package_name-$build_version.zip" "$package_name-$build_version"
rm -rf "$package_name-$build_version"
