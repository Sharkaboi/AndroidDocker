#!/bin/bash 
COMPILE_SDK = "31"
BUILD_TOOLS_VERSION = "33.0.0"
NDK_VERSION = "23.1.7779620"
SDK_TOOLS_VERSION = "9123335"

apt-get --quiet update --yes 
apt-get --quiet install --yes wget tar unzip make  
# Setup path as ANDROID_SDK_ROOT for moving/exporting the downloaded sdk into it  
export ANDROID_SDK_ROOT="${PWD}/android-home"  
# Create a new directory at specified location  
install -d $ANDROID_SDK_ROOT  
# Here we are installing androidSDK tools from official source,  
# (the key thing here is the url from where you are downloading these sdk tool for command line, so please do note this url pattern there and here as well)  
# after that unzipping those tools and  
# then running a series of SDK manager commands to install necessary android SDK packages that'll allow the app to build  
wget --output-document=$ANDROID_SDK_ROOT/cmdline-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-${SDK_TOOLS_VERSION}_latest.zip  
# move to the archive at ANDROID_SDK_ROOT  
pushd $ANDROID_SDK_ROOT  
unzip -d cmdline-tools cmdline-tools.zip  
pushd cmdline-tools  
# since commandline tools version 7583922 the root folder is named "cmdline-tools" so we rename it if necessary  
mv cmdline-tools tools || true  
popd   
export PATH=$PATH:${ANDROID_SDK_ROOT}/cmdline-tools/tools/bin/  
# Nothing fancy here, just checking sdkManager version  
sdkmanager --version  
# use yes to accept all licenses  
yes | sdkmanager --licenses || true  
sdkmanager "platforms;android-$COMPILE_SDK"  
sdkmanager "platform-tools"  
sdkmanager "build-tools;$BUILD_TOOLS_VERSION"  
export ANDROID_HOME=$ANDROID_SDK_ROOT 