#!/bin/bash

DIR="/var"

cd $DIR
for k in $(ls $DIR)
do
  [ -d $k ] && du -sh $k
done
