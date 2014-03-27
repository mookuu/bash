#!/bin/bash

#
# Modify the properties of variable

# -r: readonly
declare -r var=1
# readonly var=1                # same
((var++))                       # error: readonly variable
echo "$var"

echo

# -i: integer
declare -i number=2
echo "Number: $number"
number=three
echo "Number: $number"          # Tries to evaluate the string "three" as an integer.

echo

# -a: array
declare -a indices              # The variable indices will be treated as an array.

# -f: functions
declare -f
# A declare -f line with no arguments in a script causes a listing of all the
# functions previously defined in that script.
declare -f function_name
# A declare -f function_name in a script lists just the function named.

# -x export
declare -x var3
# This declares a variable as available for exporting outside the environment of
# the script itself.
