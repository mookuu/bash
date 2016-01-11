#!/bin/bash
# Comma is used to concatenate strings

for file in /{,usr/}bin/*calc
# Find all executable files ending in "calc"
# in /bin and /usr/bin directories.
do
    if [ -x "$file" ]
        then
        echo $file
    fi
done

#for file in /{,usr/}bin/*calc
# Results maybe
# /bin/ipcalc
# /usr/bin/kcalc
# /usr/bin/oidcalc
# /usr/bin/oocalc
# Thank you, Rory Winston, for pointing this out.
