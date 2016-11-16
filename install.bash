#!/bin/bash

mkdir -p ~/Library/Application\ Support/AssetMaker/Tmp
mkdir -p ~/Library/Application\ Support/AssetMaker/Assets

echo 'Drag and drop the Assets folder to the Dock or the Finders sidebar.'

open ~/Library/Application\ Support/AssetMaker/

cp -r src/AssetMaker.workflow ~/Library/Services

exit 0
