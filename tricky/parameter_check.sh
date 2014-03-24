#!/bin/bash


# M1:
if [ -z "$1" ]; then
        echo "M1: parameter null"
else
        echo "M1: parameter exists"
fi

# M2:
if [ -n "$1" ]; then
	echo "M2: parameter exists"
else
	echo "parameter null"
fi


# M3:
if [ x = "x$1" ]; then            # =: String comparision operator
        echo "M3: parameter null"
else
        echo "M3: parameter exists"
fi

# M4:
if [ 1 -eq "1$1" ]; then          # -eq: Arithmetic comparison operator
        echo "M4: parameter null"
else
        echo "M4: parameter exists"
fi

# M5:
if [ $1 ]; then
        echo "M5: parameter null"
else
        echo "M5: parameter exists"
fi

# M6:
if [ $# -eq 0 ]; then
        echo "M5: parameter null"
else
        echo "M5: parameter exists"
fi
