---
layout: post
title: Use mitmproxy, android emulator and adb (android debug bridge) to inspect instagram apis
tags: ["mitmproxy","android","emulator","adb","instagram","api","sdk-manager"]
---
# Setup android sdk, emulator, android debug bridge (adb)
## Setup android sdk
```bash
#intall jdk
sudo apt install openjdk-11-jdk -y

#create Adroid home and Sdk home folder
sudo mkdir -p /opt/android-sdk
sudo mkdir -p /opt/android-sdk/cmdline-tools

#install adroid commandline tools
wget https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip
sudo unzip commandlinetools-linux-7583922_latest.zip -d /opt/android-sdk/cmdline-tools
sudo ln -sf /opt/android-sdk/cmdline-tools/cmdline-tools /opt/android-sdk/cmdline-tools/latest
sudo chmod -R 777 /opt/android-sdk

#set path on console
export PATH=$PATH:/opt/android-sdk/cmdline-tools/latest/bin

#set path to user profile
echo 'PATH="$PATH:/opt/android-sdk/cmdline-tools/latest/bin"' >> ~/.profile
```
- Run sdk manager help command to check that it run correctly
```bash
sdkmanager --help
```
- List all system image
```bash
sdkmanager --list | grep system-images
```
## Install sdk
```bash
sdkmanager --install "platforms;android-29"
sdkmanager --licenses
```
## Install platform tools
```bash
sdkmanager --install "platform-tools"
```

## Download image
```bash
sdkmanager --install "system-images;android-29;default;x86"
```

## Create Emulator
```bash
echo "no" | avdmanager --verbose create avd --force --name "generic_10" --package "system-images;android-29;default;x86" --tag "default" --abi "x86"
```
- Setup emulator to PATH
```bash
echo 'PATH="$PATH:/opt/android-sdk/emulator"' >> ~/.profile
```

## Run emulator
```bash
export ANDROID_SDK_ROOT=/otp/android-sdk
emulator @generic_10 &
```

## Install instagram

```
adb uninstall com.instagram.android
adb install ~/Downloads/Instagram_v203.0.0.29.118_320303531_minAPI21\(armeabi-v7a\)\(nodpi\).apk
adb shell am force-stop com.instagram.android
adb shell monkey -p com.instagram.android -c android.intent.category.LAUNCHER 1
```

## Some useful adb command
```
adb shell "dumpsys activity | grep top-activity"
```

- Stop all open apps
```
adb shell "dumpsys activity | grep top-activity" | sed -nr "s/.*?:([a-z.]+).*?/\1/p" | xargs -l1 adb shell am force-stop
```

- Open settings
```
adb shell am start -a android.settings.SETTINGS
```

## Command to install android 30 with google api play service and create an emulator
```bash
sdkmanager --install "platforms;android-30"
sdkmanager --licenses
sdkmanager --install "platform-tools"
sdkmanager --install "system-images;android-30;google_apis_playstore;x86_64"
echo "no" | avdmanager --verbose create avd --force --name "generic_15" --package "system-images;android-30;google_apis_playstore;x86_64" --tag "google_apis_playstore" --abi "x86_64"
emulator @generic_15 &
```

# Setup mitmproxy
- Start mitmproxy and change all image to random image to reduce network traffic
```bash
sudo docker run --net=host --rm -it -v ~/.mitmproxy:/home/mitmproxy/.mitmproxy -p 8080:8080 -p 127.0.0.1:8081:8081 mitmproxy/mitmproxy mitmproxy \
--ssl-insecure \
--map-remote "|^.*\.jpg.*$|https://placedog.net/40/40?random" \
--map-remote "|^.*\.jpg.*$|https://placedog.net/40/40?random"
```
- Or start mitmproxy and change all images to default image in the local machine
```bash
sudo docker run --net=host --rm -it -v ~/.mitmproxy:/home/mitmproxy/.mitmproxy -p 8080:8080 -p 127.0.0.1:8081:8081 mitmproxy/mitmproxy mitmproxy \
--ssl-insecure \
--map-local "|^.*\.jpg.*$|/home/mitmproxy/.mitmproxy/default-image.png" \
--map-local "|^.*\.jpg.*$|/home/mitmproxy/.mitmproxy/default-image.png"
```

# Some note when run emulator on virtualbox
- List all virtualbox machine
```bash
VBoxManage list vms
```
- Virtualbox enable nested vtx/amd-v greyed out
```bash
VBoxManage modifyvm vm-name --nested-hw-virt on
```

# References:
- [https://github.com/itsMoji/Instagram_SSL_Pinning](https://github.com/itsMoji/Instagram_SSL_Pinning)
- [https://docs.mitmproxy.org/stable/howto-install-system-trusted-ca-android/](https://docs.mitmproxy.org/stable/howto-install-system-trusted-ca-android/)
- [https://gist.github.com/Pulimet/5013acf2cd5b28e55036c82c91bd56d8](https://gist.github.com/Pulimet/5013acf2cd5b28e55036c82c91bd56d8)
- [https://github.com/shroudedcode/apk-mitm](https://github.com/shroudedcode/apk-mitm)
- [https://gist.github.com/mrk-han/66ac1a724456cadf1c93f4218c6060ae](https://gist.github.com/mrk-han/66ac1a724456cadf1c93f4218c6060ae)
- [https://android.tutorials24x7.com/blog/how-to-install-android-sdk-tools-on-ubuntu-20-04](https://android.tutorials24x7.com/blog/how-to-install-android-sdk-tools-on-ubuntu-20-04)
- [https://gist.github.com/Pulimet/5013acf2cd5b28e55036c82c91bd56d8](https://gist.github.com/Pulimet/5013acf2cd5b28e55036c82c91bd56d8)
