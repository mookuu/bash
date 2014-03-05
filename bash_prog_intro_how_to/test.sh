#!/bin/sh

val=$1
if [ -d $val ]; then
    echo directory: $val
else
    echo null
fi
val=$val/
echo $val
