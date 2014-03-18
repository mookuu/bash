#!/bin/bash


# M1:
if [ -z $1 ]; then
        echo "M1: parameter null"
else
        echo "M1: parameter exists"
fi


# M2:
if [ x = x$1 ]; then            # =: String comparision operator
        echo "M2: parameter null"
else
        echo "M2: parameter exists"
fi

# M3:
if [ 1 -eq 1$1 ]; then          # -eq: Arithmetic comparison operator
        echo "M3: parameter null"
else
        echo "M3: parameter exists"
fi
