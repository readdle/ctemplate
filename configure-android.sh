#!/bin/sh

set -ex

current_dir="$(dirname "$0")"
temp_dir="/tmp/ctemplate"
cd $current_dir

rm -rf $temp_dir
mkdir -p $temp_dir

export TOOLCHAIN=$ANDROID_NDK/toolchains/llvm/prebuilt/darwin-x86_64
export TARGET=aarch64-linux-android
export API=24
export AR=$TOOLCHAIN/bin/llvm-ar
export CC=$TOOLCHAIN/bin/$TARGET$API-clang
export AS=$CC
export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
export LD=$TOOLCHAIN/bin/ld
export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
export STRIP=$TOOLCHAIN/bin/llvm-strip

# Configure ctemplate for Android
cp -r ./* $temp_dir
pushd $temp_dir
	./configure --host=$TARGET
	./src/htmlparser/generate_fsm.py ./src/htmlparser/htmlparser_fsm.config > src/htmlparser/htmlparser_fsm.h
	./src/htmlparser/generate_fsm.py ./src/htmlparser/jsparser_fsm.config > src/htmlparser/jsparser_fsm.h
popd

cp $temp_dir/src/config.h ./config/android

cp $temp_dir/src/ctemplate/find_ptr.h ./include/android/ctemplate
cp $temp_dir/src/ctemplate/per_expand_data.h ./include/android/ctemplate
cp $temp_dir/src/ctemplate/str_ref.h ./include/android/ctemplate
cp $temp_dir/src/ctemplate/template_annotator.h ./include/android/ctemplate
cp $temp_dir/src/ctemplate/template_cache.h ./include/android/ctemplate
cp $temp_dir/src/ctemplate/template_dictionary_interface.h ./include/android/ctemplate
cp $temp_dir/src/ctemplate/template_dictionary.h ./include/android/ctemplate
cp $temp_dir/src/ctemplate/template_emitter.h ./include/android/ctemplate
cp $temp_dir/src/ctemplate/template_enums.h ./include/android/ctemplate
cp $temp_dir/src/ctemplate/template_modifiers.h ./include/android/ctemplate
cp $temp_dir/src/ctemplate/template_namelist.h ./include/android/ctemplate
cp $temp_dir/src/ctemplate/template_pathops.h ./include/android/ctemplate
cp $temp_dir/src/ctemplate/template_string.h ./include/android/ctemplate
cp $temp_dir/src/ctemplate/template.h ./include/android/ctemplate
cp $temp_dir/src/htmlparser/htmlparser_fsm.h ./include/android/htmlparser
cp $temp_dir/src/htmlparser/jsparser_fsm.h ./include/android/htmlparser

