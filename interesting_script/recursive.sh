#!/bin/bash

# recursive multiplication
function main()
{
        local tmp=0
        local tmp_result=0

        if [ $1 -le 1 ]; then
                result=1
                return 0            # ignore-->$?
        else
                (( tmp=$1-1 ))
                main $tmp
                (( tmp_result=$1*$result ))
                result=$tmp_result
                return 0
        fi
}

main $1

echo "Factorial of $1 is: $result"
