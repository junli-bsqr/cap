##
 # Copyright (c) 2016 Google Inc.
 # All rights reserved.
 #
 # Redistribution and use in source and binary forms, with or without
 # modification, are permitted provided that the following conditions are met:
 # 1. Redistributions of source code must retain the above copyright notice,
 # this list of conditions and the following disclaimer.
 # 2. Redistributions in binary form must reproduce the above copyright notice,
 # this list of conditions and the following disclaimer in the documentation
 # and/or other materials provided with the distribution.
 # 3. Neither the name of the copyright holder nor the names of its
 # contributors may be used to endorse or promote products derived from this
 # software without specific prior written permission.
 #
 # THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 # AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 # THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 # PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 # CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 # EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 # PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 # OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 # WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 # OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 # ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 ##

LOCAL_PATH := $(call my-dir)

ARCHE_ROOT := $(CURDIR)
FDK_PATH := $(ARCHE_ROOT)/vendor/google/unipro-firmware
MCL_TMP_OUT_DIR := $(TARGET_OUT_INTERMEDIATES)/ARA_MIRACL_CRYPTO_LIB_OBJ

MIRACL_TOPDIR := $(FDK_PATH)/bootrom/common/vendors/MIRACL
APP_MCL_CONFIG_DIR := $(ARCHE_ROOT)/$(LOCAL_PATH)/MCL_cfg
MCL_OUT := $(ARCHE_ROOT)/$(MCL_TMP_OUT_DIR)

include $(LOCAL_PATH)/MCL.mk

include $(CLEAR_VARS)
LOCAL_MODULE := libaracap
LOCAL_SRC_FILES := libaracap.c
LOCAL_MULTILIB := 64
LOCAL_CFLAGS := $(MIRACL_CFLAGS)
LOCAL_C_INCLUDES := $(FDK_PATH)/bootrom/common/shared_inc
LOCAL_WHOLE_STATIC_LIBRARIES := libmclcurve$(DREC1) libmclcurve$(DREC2) libmclcore
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)
include $(BUILD_STATIC_LIBRARY)

LOCAL_PATH := $(MCL_TMP_OUT_DIR)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := lib/libmclcore.a
LOCAL_MODULE := libmclcore
LOCAL_MODULE_SUFFIX := .a
LOCAL_MODULE_CLASS := STATIC_LIBRARIES
LOCAL_MODULE_PATH := $(LOCAL_PATH)
LOCAL_EXPORT_C_INCLUDE_DIRS := $(MIRACL_TOPDIR)/ara/include
$(LOCAL_PATH)/$(LOCAL_SRC_FILES): $(LIBMCLCORE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := libmclcurve$(DREC1)
LOCAL_SRC_FILES := $(DREC1)/lib/libmclcurve$(DREC1).a
LOCAL_MODULE_CLASS := STATIC_LIBRARIES
LOCAL_MODULE_SUFFIX := .a
LOCAL_MODULE_PATH := $(LOCAL_PATH)
LOCAL_EXPORT_C_INCLUDE_DIRS := $(MIRACL_TOPDIR)/ara/include
$(LOCAL_PATH)/$(LOCAL_SRC_FILES): $(LIBMCLCURVE1)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := libmclcurve$(DREC2)
LOCAL_SRC_FILES := $(DREC2)/lib/libmclcurve$(DREC2).a
LOCAL_MODULE_CLASS := STATIC_LIBRARIES
LOCAL_MODULE_SUFFIX := .a
LOCAL_MODULE_PATH := $(LOCAL_PATH)
LOCAL_EXPORT_C_INCLUDE_DIRS := $(MIRACL_TOPDIR)/ara/include
$(LOCAL_PATH)/$(LOCAL_SRC_FILES): $(LIBMCLCURVE2)
include $(BUILD_PREBUILT)
