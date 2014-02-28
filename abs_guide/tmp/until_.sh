#!/bin/bash

val=5

until [ "$val" -eq "5" ]
do
    echo "val=$val"
    ((val++))
done

exit 0
