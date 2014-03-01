#!/bin/bash

# Some triky to get size of terminal

echo "-------------------"
echo "M1: stty size"
echo $(stty size)

echo "-------------------"
echo "M2: tput lines | tput cols"
echo  $(tput lines) $(tput cols)

echo "-------------------"
echo 'M3: $LINES $COLUMNS in terminal'
echo "$LINES $COLUMNS"

echo "-------------------"
