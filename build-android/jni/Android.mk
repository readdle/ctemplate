LOCAL_PATH := $(realpath $(call my-dir))
BASE_PATH := $(realpath $(LOCAL_PATH)/../..)

src_dir := $(BASE_PATH)/src

src_files = \
  htmlparser/htmlparser.cc \
  htmlparser/jsparser.cc \
  htmlparser/statemachine.cc \
  base/arena.cc \
  per_expand_data.cc \
  template.cc \
  template_dictionary.cc \
  template_pathops.cc \
  template_annotator.cc \
  template_modifiers.cc \
  template_string.cc \
  template_cache.cc \
  template_namelist.cc


include $(CLEAR_VARS)
LOCAL_C_INCLUDES := \
  $(BASE_PATH)/build-android/include \
  $(src_dir) \

LOCAL_MODULE := ctemplate
LOCAL_SRC_FILES := $(addprefix $(src_dir)/, $(src_files))
include $(BUILD_STATIC_LIBRARY)
