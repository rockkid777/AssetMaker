#!/bin/bash

assetDir="/Users/$USER/Library/Application Support/AssetMaker/Assets"
tmpDir="/Users/$USER/Library/Application Support/AssetMaker/Tmp"

function max {
    if [ $1 -lt $2 ]; then
        echo $2
    else
        echo $1
    fi
}

function processImage {
    filePath=$1
    fullFileName=$(basename "$filePath")
    fileExtension="${fullFileName##*.}"
    fileName="$(echo ${fullFileName%.*} | sed 's/\(.*\)\(\@3x\)/\1/g')"

    if [ ! "$fileExtension" == "png" ]; then
        return 1
    fi

    width=$(sips -g pixelWidth "$filePath" | grep -o ': [0-9]\+' | cut -f2 -d' ')
    height=$(sips -g pixelHeight "$filePath" | grep -o ': [0-9]\+' | cut -f2 -d' ')
    size=$(max $width $height)
    smallSize=$(($size / 3))
    mediumSize=$(($smallSize * 2))

    cp "$filePath" "$tmpDir/$fileName@3x.png"
    cp "$filePath" "$tmpDir/$fileName@2x.png"
    cp "$filePath" "$tmpDir/$fileName.png"

    sips -Z $smallSize "$tmpDir/$fileName.png" >/dev/null
    sips -Z $mediumSize "$tmpDir/$fileName@2x.png" >/dev/null

    mv "$tmpDir/$fileName"*.png "$assetDir"/
}

for file in $@
do
    echo "Processing $file ..."
    processImage $file
done

exit 0
