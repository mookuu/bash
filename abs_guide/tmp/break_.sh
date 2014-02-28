#!/bin/bash

val=0

while true
do
if [ "$val" -eq "5" ]; then
    break;
else
    echo "val=$val"
    ((val++))
fi
done
