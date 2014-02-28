#!/bin/bash

str="hello world"

# Length of string: ${#str}
echo "Length of str:${#str}"

# Get substring(from n): ${str:n}
echo "Substring:${str:7}"

# Get substring(from m to n length words): ${str:m:n}
echo "Substring2:${str:7:2}"

# Delete shortest words matched with specified words from beginning of string
echo "Delete:${str#hello}"
#echo "Delete:${str#*lo}"

# Delete shortest words matched with specified words from end of string
echo "Delete2:${str%world}"
#echo "Delete2:${str%wor*}"

# Replace character 'm' with 'n'
echo "Repalcement:${str//o/8}"
#echo ${str}

# Duplicate lines commnet M1:
:||{
    echo comment out!
    echo ...
}

# Duplicate lines commnet M2:
if false; then
    echo comment out!
    echo ...
fi
