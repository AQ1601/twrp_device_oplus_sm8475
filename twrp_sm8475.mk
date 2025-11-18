#
# Copyright (C) 2025 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/oplus/sm8475

# Inherit from device.mk configuration
$(call inherit-product, $(DEVICE_PATH)/device.mk)

## Device identifier
PRODUCT_DEVICE  := sm8475
PRODUCT_NAME    := twrp_sm8475
PRODUCT_BRAND   := oplus

# Theme
TW_STATUS_ICONS_ALIGN   := center
TW_Y_OFFSET             := 111
TW_H_OFFSET             := -111
