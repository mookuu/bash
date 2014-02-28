#!/bin/bash

CUR="/home/gemini/workspace/cs/bash/abs_guide"
CUR_DIR=`ls`                    # not single quote mark
#CUR_DIR='ls'                    # single quote mark forbidden the extesnsion of variable
#echo $CUR_DIR


for val in $CUR_DIR       #
do                        #
    if [ -f $val ]; then  #
        echo "File: $val" #
    else                  #
        echo "other type" #
    fi                    #
done                      #
