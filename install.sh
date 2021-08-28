#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
  if brew ls --versions opencv > /dev/null; then
    echo
    echo "Welcome to the jPhotoDNA installer."
    echo "The script will now setup a jPhotoDNA environment for you. Please be patient."
    
    echo
    echo "Downloading BlackLight (1.8GB, might take a while)..."
    curl -LO https://s3-us-west-2.amazonaws.com/bbt-software-releases/0100_BlackLight/BlackLight_Mac_Setup_2020r1.pkg
    
    echo
    echo "Extracting PhotoDNAx64.so."
    pkgutil --expand-full BlackLight_Mac_Setup_2020r1.pkg BL
    rm BlackLight_Mac_Setup_2020r1.pkg
    mv BL/BlackLight.pkg/Payload/Applications/BlackLight/BlackLight\ 2020\ Release\ 1/BlackLight.app/Contents/Resources/Mac/artifact_parser/PhotoDNAx64-osx.so.1.72 PhotoDNAx64.so
    rm -rf BL
    
    echo
    echo "Downloading jPhotoDNA"
    curl -LO https://github.com/jankais3r/jPhotoDNA/releases/download/v0.1-mac/jPhotoDNA-mac.zip
    
    echo
    echo "Extracting jPhotoDNA"
    unzip -qq jPhotoDNA-mac.zip
    rm -rf __MACOSX
    rm jPhotoDNA-mac.zip
    
    echo
    echo
    echo "Installation complete!"
    echo "_____________________________"
    echo
    echo "To generate a PhotoDNA hash, use the following syntax:"
    echo "jPhotoDNA.app/Contents/MacOS/jPhotoDNA " $(pwd)"/PhotoDNAx64.so image.jpg"
    
    echo
    echo "Generating a validation hash:"
    jPhotoDNA.app/Contents/MacOS/jPhotoDNA $(pwd)/PhotoDNAx64.so Windmill.jpg
  else
    echo
    echo "Dependency missing (opencv). Please install it by running the following command:"
    echo "brew install opencv"
  fi
else
  echo "jPhotoDNA does not support Linux. Please run install.sh on a Mac."
fi
