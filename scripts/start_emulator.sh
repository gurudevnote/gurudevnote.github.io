#!/bin/bash
#image="system-images;android-30;google_apis_playstore;x86_64"
image=$1
echo "install image: $image"
platforms=`echo $image | awk -F ';' '{print $2}'`
tag=`echo $image | awk -F ';' '{print $3}'`
abi=`echo $image | awk -F ';' '{print $4}'`
name="$platforms$abi$tag"
echo "$platforms"
echo "create emulator: $name"
sdkmanager --install "platforms;$platforms"
sdkmanager --licenses
sdkmanager --install "platform-tools"
sdkmanager --install "$image"
exist_adv=`avdmanager list avd | grep $name`
if [[ -z `echo $exist_adv` ]]; then
    echo "Crete adv $name"
    echo "no" | avdmanager --verbose create avd --force --name "$name" --package "$image" --tag "$tag" --abi "$abi"
fi

emulator "@$name"

#example to user this script
#./start_emulator.sh "system-images;android-30;google_apis_playstore;x86_64"