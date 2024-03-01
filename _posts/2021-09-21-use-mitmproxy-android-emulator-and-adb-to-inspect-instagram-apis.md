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
wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip
sudo unzip commandlinetools-linux-9477386_latest.zip -d /opt/android-sdk/cmdline-tools
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

- top activity
```
adb shell "dumpsys activity | grep top-activity"
```

- list all installed app
```
adb shell cmd package list packages
```

- Click to home screen
```
adb shell input keyevent 3
```

- There are some key code
```
0 -->  "KEYCODE_UNKNOWN" 
1 -->  "KEYCODE_MENU" 
2 -->  "KEYCODE_SOFT_RIGHT" 
3 -->  "KEYCODE_HOME" 
4 -->  "KEYCODE_BACK" 
5 -->  "KEYCODE_CALL" 
6 -->  "KEYCODE_ENDCALL" 
7 -->  "KEYCODE_0" 
8 -->  "KEYCODE_1" 
9 -->  "KEYCODE_2" 
10 -->  "KEYCODE_3" 
11 -->  "KEYCODE_4" 
12 -->  "KEYCODE_5" 
13 -->  "KEYCODE_6" 
14 -->  "KEYCODE_7" 
15 -->  "KEYCODE_8" 
16 -->  "KEYCODE_9" 
17 -->  "KEYCODE_STAR" 
18 -->  "KEYCODE_POUND" 
19 -->  "KEYCODE_DPAD_UP" 
20 -->  "KEYCODE_DPAD_DOWN" 
21 -->  "KEYCODE_DPAD_LEFT" 
22 -->  "KEYCODE_DPAD_RIGHT" 
23 -->  "KEYCODE_DPAD_CENTER" 
24 -->  "KEYCODE_VOLUME_UP" 
25 -->  "KEYCODE_VOLUME_DOWN" 
26 -->  "KEYCODE_POWER" 
27 -->  "KEYCODE_CAMERA" 
28 -->  "KEYCODE_CLEAR" 
29 -->  "KEYCODE_A" 
30 -->  "KEYCODE_B" 
31 -->  "KEYCODE_C" 
32 -->  "KEYCODE_D" 
33 -->  "KEYCODE_E" 
34 -->  "KEYCODE_F" 
35 -->  "KEYCODE_G" 
36 -->  "KEYCODE_H" 
37 -->  "KEYCODE_I" 
38 -->  "KEYCODE_J" 
39 -->  "KEYCODE_K" 
40 -->  "KEYCODE_L" 
41 -->  "KEYCODE_M" 
42 -->  "KEYCODE_N" 
43 -->  "KEYCODE_O" 
44 -->  "KEYCODE_P" 
45 -->  "KEYCODE_Q" 
46 -->  "KEYCODE_R" 
47 -->  "KEYCODE_S" 
48 -->  "KEYCODE_T" 
49 -->  "KEYCODE_U" 
50 -->  "KEYCODE_V" 
51 -->  "KEYCODE_W" 
52 -->  "KEYCODE_X" 
53 -->  "KEYCODE_Y" 
54 -->  "KEYCODE_Z" 
55 -->  "KEYCODE_COMMA" 
56 -->  "KEYCODE_PERIOD" 
57 -->  "KEYCODE_ALT_LEFT" 
58 -->  "KEYCODE_ALT_RIGHT" 
59 -->  "KEYCODE_SHIFT_LEFT" 
60 -->  "KEYCODE_SHIFT_RIGHT" 
61 -->  "KEYCODE_TAB" 
62 -->  "KEYCODE_SPACE" 
63 -->  "KEYCODE_SYM" 
64 -->  "KEYCODE_EXPLORER" 
65 -->  "KEYCODE_ENVELOPE" 
66 -->  "KEYCODE_ENTER" 
67 -->  "KEYCODE_DEL" 
68 -->  "KEYCODE_GRAVE" 
69 -->  "KEYCODE_MINUS" 
70 -->  "KEYCODE_EQUALS" 
71 -->  "KEYCODE_LEFT_BRACKET" 
72 -->  "KEYCODE_RIGHT_BRACKET" 
73 -->  "KEYCODE_BACKSLASH" 
74 -->  "KEYCODE_SEMICOLON" 
75 -->  "KEYCODE_APOSTROPHE" 
76 -->  "KEYCODE_SLASH" 
77 -->  "KEYCODE_AT" 
78 -->  "KEYCODE_NUM" 
79 -->  "KEYCODE_HEADSETHOOK" 
80 -->  "KEYCODE_FOCUS" 
81 -->  "KEYCODE_PLUS" 
82 -->  "KEYCODE_MENU" 
83 -->  "KEYCODE_NOTIFICATION" 
84 -->  "KEYCODE_SEARCH" 
85 -->  "TAG_LAST_KEYCODE"
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

- Remove an adv

```bash
avdmanager delete avd --name <AVD_name>
```

## write a [script](/scripts/start_emulator.sh) to install image and then start emulator
```bash
#!/bin/bash
#image="system-images;android-30;google_apis_playstore;x86_64"
image=$1
echo "install image: $image"
platforms=`echo $image | awk -F ';' '{print $2}'`
tag=`echo $image | awk -F ';' '{print $3}'`
abi=`echo $image | awk -F ';' '{print $4}'`
name="$platforms$abi_$tag"
echo "create emulator: $name"
sdkmanager --install "platforms;$platforms"
sdkmanager --licenses
sdkmanager --install "platform-tools"
sdkmanager --install "$image"
echo "no" | avdmanager --verbose create avd --force --name "$name" --package "$image" --tag "$tag" --abi "$abi"
emulator "@$name" &
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
- [https://github.com/Eltion/Instagram-SSL-Pinning-Bypass](https://github.com/Eltion/Instagram-SSL-Pinning-Bypass)
- [https://docs.mitmproxy.org/stable/howto-install-system-trusted-ca-android/](https://docs.mitmproxy.org/stable/howto-install-system-trusted-ca-android/)
- [https://gist.github.com/Pulimet/5013acf2cd5b28e55036c82c91bd56d8](https://gist.github.com/Pulimet/5013acf2cd5b28e55036c82c91bd56d8)
- [https://github.com/shroudedcode/apk-mitm](https://github.com/shroudedcode/apk-mitm)
- [https://gist.github.com/mrk-han/66ac1a724456cadf1c93f4218c6060ae](https://gist.github.com/mrk-han/66ac1a724456cadf1c93f4218c6060ae)
- [https://android.tutorials24x7.com/blog/how-to-install-android-sdk-tools-on-ubuntu-20-04](https://android.tutorials24x7.com/blog/how-to-install-android-sdk-tools-on-ubuntu-20-04)
- [https://gist.github.com/Pulimet/5013acf2cd5b28e55036c82c91bd56d8](https://gist.github.com/Pulimet/5013acf2cd5b28e55036c82c91bd56d8)
- [https://stackoverflow.com/questions/7789826/adb-shell-input-events](https://stackoverflow.com/questions/7789826/adb-shell-input-events)