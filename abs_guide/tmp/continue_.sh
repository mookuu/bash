#!/bin/bash

val=0

while [ "$val" -le "10" ]
do
if [ "$val" -eq "5" ]; then
    echo "val=$val"
    ((val=val+2))
else
    echo "val=$val"
    ((val++))
fi
done
