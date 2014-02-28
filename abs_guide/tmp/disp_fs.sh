#!/bin/bash
# This shell is used for filesystem usage display

DIR="/var"

cd $DIR
for k in $( ls $DIR )
do
    [ -d $k ] && du -sh $k
done
