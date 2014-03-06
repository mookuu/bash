#! /bin/bash

# recursive multiplication

function factorial
{
        local tmp_val=0
        local next_num=0
        if (( $1<=1 )); then
                result=1
                return 0
        else
                (( next_num=$1 - 1 ))
                factorial $next_num
                (( tmp_val=$1 * $result ))
                result=$tmp_val
                return 0
        fi
}

factorial $1

echo "Factorial of $1 is:$result"
