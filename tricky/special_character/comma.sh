#!/bin/bash

# set m = 5, n = 3
let "m=(n=3, 15/3)"
echo "m = $m, n = $n"
# n=3, m=5

# M2: concatenate strings
# /bin/n*
# /usr/bin/n*
for file in /{,usr/}bin/n*
do
        if [ -x "$file" ]; then
                echo "$file exists and executable."
        else
                echo "$file cannot execute "
        fi
done


