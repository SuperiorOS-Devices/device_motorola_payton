#
# Copyright (C) 2017 The LineageOS Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit some common AOSP stuff.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Inherit some common SuperiorOS stuff.
$(call inherit-product, vendor/superior/config/common.mk)
TARGET_BOOT_ANIMATION_RES := 1080

# Device
$(call inherit-product, device/motorola/payton/device.mk)

# Quick Tap
TARGET_SUPPORTS_QUICK_TAP := true

# Do not ship live wallpapers
TARGET_INCLUDE_LIVE_WALLPAPERS := false

# A/B updater
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

PRODUCT_PACKAGES += \
    otapreopt_script \
    update_engine \
    update_engine_sideload \
    update_verifier

# The following modules are included in debuggable builds only.
PRODUCT_PACKAGES_DEBUG += \
    bootctl \
    update_engine_client

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl.recovery \
    bootctrl.sdm660 \
    bootctrl.sdm660.recovery

# TWRP
ifeq ($(WITH_TWRP),true)
    $(call inherit-product, device/motorola/payton/twrp/twrp.mk)
else
    TARGET_RECOVERY_FSTAB := device/motorola/payton/rootdir/etc/fstab.qcom
endif

# Device identifiers
PRODUCT_DEVICE := payton
PRODUCT_NAME := superior_payton
PRODUCT_BRAND := motorola
PRODUCT_MODEL := Moto X4
PRODUCT_MANUFACTURER := Motorola

PRODUCT_BUILD_PROP_OVERRIDES += \
        PRIVATE_BUILD_DESC="redfin-user-13-TQ1A.221205.011-9244662-release-keys" \
        PRODUCT_NAME=payton

BUILD_FINGERPRINT := google/redfin/redfin:13/TQ1A.221205.011/9244662:user/release-keys
