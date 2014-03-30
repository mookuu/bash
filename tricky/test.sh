#!/bin/bash

CUR_DIR=`pwd`
E_DIRWRONG=85
# Filename
if [ -d "${1%%.*}" ]; then
        echo "Directory exists, overwriten?"
        echo "errno: $E_DIRWRONG" && exit "$E_DIRWRONG"
else
        mkdir ${1%%.*} && cp "$1" "$_" && cd "$_"
fi
UNPACK=$?
echo This is a rar package.
