#!/bin/bash

set -ex

current_dir="$(dirname "$0")"
temp_dir="/tmp/ctemplate"
cd $current_dir

rm -rf $temp_dir
mkdir -p $temp_dir

# Configure ctemplate for Linux, natively on a Linux host
cp -r ./* $temp_dir
pushd $temp_dir
	./configure
	# generate_fsm.py and fsm_config.py are Python 2, which current distributions no longer ship (python3-lib2to3 converts them)
	python3 -m lib2to3 --write --nobackups --no-diffs ./src/htmlparser/generate_fsm.py ./src/htmlparser/fsm_config.py
	# Python 3 repr() keeps non-ASCII characters, ascii() escapes them as Python 2 repr() did
	sed -i 's/repr(chr(c))/ascii(chr(c))/' ./src/htmlparser/generate_fsm.py
	python3 ./src/htmlparser/generate_fsm.py ./src/htmlparser/htmlparser_fsm.config > src/htmlparser/htmlparser_fsm.h
	python3 ./src/htmlparser/generate_fsm.py ./src/htmlparser/jsparser_fsm.config > src/htmlparser/jsparser_fsm.h
popd

mkdir -p ./config/linux ./include/linux/ctemplate ./include/linux/htmlparser
cp $temp_dir/src/config.h ./config/linux

cp $temp_dir/src/ctemplate/find_ptr.h ./include/linux/ctemplate
cp $temp_dir/src/ctemplate/per_expand_data.h ./include/linux/ctemplate
cp $temp_dir/src/ctemplate/str_ref.h ./include/linux/ctemplate
cp $temp_dir/src/ctemplate/template_annotator.h ./include/linux/ctemplate
cp $temp_dir/src/ctemplate/template_cache.h ./include/linux/ctemplate
cp $temp_dir/src/ctemplate/template_dictionary_interface.h ./include/linux/ctemplate
cp $temp_dir/src/ctemplate/template_dictionary.h ./include/linux/ctemplate
cp $temp_dir/src/ctemplate/template_emitter.h ./include/linux/ctemplate
cp $temp_dir/src/ctemplate/template_enums.h ./include/linux/ctemplate
cp $temp_dir/src/ctemplate/template_modifiers.h ./include/linux/ctemplate
cp $temp_dir/src/ctemplate/template_namelist.h ./include/linux/ctemplate
cp $temp_dir/src/ctemplate/template_pathops.h ./include/linux/ctemplate
cp $temp_dir/src/ctemplate/template_string.h ./include/linux/ctemplate
cp $temp_dir/src/ctemplate/template.h ./include/linux/ctemplate
cp $temp_dir/src/htmlparser/htmlparser_fsm.h ./include/linux/htmlparser
cp $temp_dir/src/htmlparser/jsparser_fsm.h ./include/linux/htmlparser
