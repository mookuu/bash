#!/bin/bash

# Arguments from CLI
echo "$2"                       # Arguments passed to the script from command line: $1, $2, $3...
echo "$1"
echo "$3"
...
echo ${10}                      # Arguments greater than 9 must be enclosed in brackets.

# Other special command
$#                              # Numbers of arguments passed by
$*                              # seperate argument

# Get last argument
# M1
lastarg=${!#}
echo $lastarg

# M2
total=$#
lastarg=${!total}
echo "lastarg"

