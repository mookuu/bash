#!/bin/bash

sum=0

#for ((i=1;i<10;i++))
#for i in `seq 1 9`;
for i in $(seq 1 9)
do
    echo $i
    ((sum=$sum+$i))
done

echo "sum=$sum"

exit 0
