#!/bin/bash

# set m = 5, n = 3
let "m=(n=3, 15/3)"
echo "m = $m, n = $n"

for file in /{,usr/}bin/n*
do
        if [ -x "$file" ]; then
                echo "$file exists and executable."
        else
                echo "$file cannot execute "
        fi
done
