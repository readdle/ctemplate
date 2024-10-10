#!/bin/sh

set -ex

current_dir="$(dirname "$0")"
temp_dir="/tmp/ctemplate"
cd $current_dir

rm -rf $temp_dir
mkdir -p $temp_dir

# Configure ctemplate for Android
cp -r ./* $temp_dir
pushd $temp_dir
	./configure --host=$TARGET
	./src/htmlparser/generate_fsm.py ./src/htmlparser/htmlparser_fsm.config > src/htmlparser/htmlparser_fsm.h
	./src/htmlparser/generate_fsm.py ./src/htmlparser/jsparser_fsm.config > src/htmlparser/jsparser_fsm.h
popd

cp $temp_dir/src/config.h ./config/apple

cp $temp_dir/src/ctemplate/find_ptr.h ./include/apple/ctemplate
cp $temp_dir/src/ctemplate/per_expand_data.h ./include/apple/ctemplate
cp $temp_dir/src/ctemplate/str_ref.h ./include/apple/ctemplate
cp $temp_dir/src/ctemplate/template_annotator.h ./include/apple/ctemplate
cp $temp_dir/src/ctemplate/template_cache.h ./include/apple/ctemplate
cp $temp_dir/src/ctemplate/template_dictionary_interface.h ./include/apple/ctemplate
cp $temp_dir/src/ctemplate/template_dictionary.h ./include/apple/ctemplate
cp $temp_dir/src/ctemplate/template_emitter.h ./include/apple/ctemplate
cp $temp_dir/src/ctemplate/template_enums.h ./include/apple/ctemplate
cp $temp_dir/src/ctemplate/template_modifiers.h ./include/apple/ctemplate
cp $temp_dir/src/ctemplate/template_namelist.h ./include/apple/ctemplate
cp $temp_dir/src/ctemplate/template_pathops.h ./include/apple/ctemplate
cp $temp_dir/src/ctemplate/template_string.h ./include/apple/ctemplate
cp $temp_dir/src/ctemplate/template.h ./include/apple/ctemplate
cp $temp_dir/src/htmlparser/htmlparser_fsm.h ./include/apple/htmlparser
cp $temp_dir/src/htmlparser/jsparser_fsm.h ./include/apple/htmlparser
