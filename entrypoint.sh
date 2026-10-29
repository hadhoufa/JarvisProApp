#!/bin/bash
# Force non-interactive mode for any script
export DEBIAN_FRONTEND=noninteractive
export PIP_NO_INPUT=1
export PIP_DISABLE_PIP_VERSION_CHECK=1
export DEBCONF_NONINTERACTIVE_SEEN=true
export ANDROID_HOME=/root/.buildozer/android/platform/android-sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME

# Accept all Android SDK licenses automatically
mkdir -p $ANDROID_HOME/licenses
echo "24333f8a63b6825ea9c5514f83c2829b004d1fee" > $ANDROID_HOME/licenses/android-sdk-license
echo "84831b9409646a918e30573bab4c9c91346d8abd" > $ANDROID_HOME/licenses/android-sdk-preview-license

# Run buildozer
buildozer android debug
