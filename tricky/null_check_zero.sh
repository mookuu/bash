#!/bin/bash
#
# null parameter check
# for safe, quoted the test string
# in case of whiltespace

# M1: [ -z ]; z for null parameter(zero length)
if [ -z "$string" ]; then	# Recommanded
	echo "null length"
else
	echo "not null"
fi # null length

if [ -z $string ]; then
	echo "null length"
else
	echo "not null"
fi # null length

# M2: [ -n ]; n for not null(non-zero\)
if [ -n "$string" ]; then	# Recommanded
        echo "not null"
else
        echo "null length"
fi # null length

if [ -n $string ]; then
        echo "not null"
else
        echo "null length"
fi # not null, maybe checked the bracket ']'

# M3: [] only.
if [ "$string" ]; then		# Recommanded
        echo "not null"
else
        echo "null length"
fi # null length

if [ $string ]; then
        echo "not null"
else
        echo "null length"
fi # null length
