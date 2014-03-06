#!/bin/sh
for filen in *
do
fn=`echo $filen |cut -d "." -f 1`
ext=`echo $filen |cut -d "." -f 2`
if [ $ext = $1 ];then
#echo "$filen -> $fn.$2"
#mv $filen  $fn.$2
    echo "test here"
fi
done
