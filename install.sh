#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
  if brew ls --versions opencv > /dev/null; then
    echo
    echo "Welcome to the jPhotoDNA installer."
    echo "The script will now setup a jPhotoDNA environment for you. Please be patient."
    
    echo
    echo "Downloading Inspector (4.4 GB, might take a while)..."
    curl -LO https://archive.org/download/cellebrite-inspector-10.3-mac/Cellebrite_Inspector_10.3_Mac.pkg
    
    echo
    echo "Extracting PhotoDNAx64.so."
    pkgutil --expand-full Cellebrite_Inspector_10.3_Mac.pkg Inspector
    rm Cellebrite_Inspector_10.3_Mac.pkg
    mv "Inspector/Inspector.pkg/Payload/Applications/Inspector/Inspector 10.3/Inspector.app/Contents/Helpers/Mac/PhotoDNAx64-osx.so.1.72" PhotoDNAx64.so
    rm -rf Inspector
    
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