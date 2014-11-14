#!/bin/bash

echo a
[ 1 -eq 2 -a -n "`echo test 1>&2`" ]    # Wrong result
# Result: test, short-circuit NG
echo c
