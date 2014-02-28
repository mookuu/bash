#!/bin/bash

for k in $( seq 1 10 )
do
    mkdir ./aaa${k}
    cd aaa${k}

    for l in $( seq 1 10 )
    do
        mkdir bbb${l}
    done

    cd ..
done
