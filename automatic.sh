#!/bin/bash

# https://bitbucket.org/iBotPeaches/apktool/downloads/
# git clone https://github.com/creador/ti_recover.git && cd ti_recover && npm install

# Unpack APK
echo "+ Unpacking files ...";
mkdir -p decompiled/app/src/main/
unzip *.apk -d decompiled/app/src/main/

for dexfile in decompiled/app/src/main/classe*.dex; do

    # dex to jar
    echo "+ Transform classes ...";
    # Source: https://github.com/pxb1988/dex2jar
    cd resources/dex2jar-2.0/
    ./d2j-dex2jar.sh "../../${dexfile}" -o "../../${dexfile}.jar"
    cd ../../

    echo "+ Reversing jar files ...";
    # Source: http://www.benf.org/other/cfr/
    cd resources/
    java -jar cfr_0_119.jar "../${dexfile}.jar" --outputdir ../decompiled/app/src/main/java/
    cd ..

done


# Decode resources
echo "+ Unpack static resources ...";
# Source: https://ibotpeaches.github.io/Apktool/
cd resources/
java -jar apktool_2.2.2.jar d ../*.apk -o ../decompiled/res-out/
rm -f ../decompiled/app/src/main/AndroidManifest.xml
rm -f ../decompiled/app/src/main/resources.arsc
rm -rf ../decompiled/app/src/main/res
mv ../decompiled/res-out/*.xml ../decompiled/app/src/main/
mv ../decompiled/res-out/*.yml ../decompiled/app/src/main/
mv ../decompiled/res-out/res ../decompiled/app/src/main/
rm -rf ../decompiled/res-out
cd ..

# Decode appcelerator
if [ -d "decompiled/app/src/main/java/appcelerator" -o -d "decompiled/app/src/main/org/appcelerator" ]; then
    echo "+ Appcelerator detected. Decompiling core files ...";
    # Source: https://github.com/creador/ti_recover
    cd resources/ti_recover/
    rm -rf ../../decompiled/app/src/main/assets/Resources/*
    ./cli ../../*.apk ../../decompiled/app/src/main/assets/Resources/
    cd ../../
fi

echo "+ Clean files ...";
rm -f decompiled/app/src/main/classes.dex
rm -f decompiled/app/src/main/classes.jar
rm -f decompiled/app/src/main/java/summary.txt

echo "+ Finish!";