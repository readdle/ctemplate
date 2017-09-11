LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

src_files = \
  htmlparser/htmlparser.cc \
  htmlparser/jsparser.cc \
  htmlparser/statemachine.cc \
  base/arena.cc \
  per_expand_data.cc \
  template.cc            template_dictionary.cc template_pathops.cc \
  template_annotator.cc  template_modifiers.cc  template_string.cc \
  template_cache.cc      template_namelist.cc

src_dir := $(LOCAL_PATH)/../../src

NDK_TOOLCHAIN_VERSION := clang
LOCAL_C_INCLUDES := $(src_dir)/../build-android/include $(src_dir) \
  $(ANDROID_NDK)/sources/android/support/include \
  $(ANDROID_NDK)/sources/cxx-stl/llvm-libc++/libcxx/include \
  $(ANDROID_NDK)/sources/cxx-stl/llvm-libc++/include
LOCAL_MODULE := ctemplate
LOCAL_SRC_FILES := $(addprefix $(src_dir)/, $(src_files))

include $(BUILD_STATIC_LIBRARY)
