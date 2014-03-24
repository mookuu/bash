#!/bin/bash

# M1: test not support for float compute
[ "$1" -ge 0 ] 2>/dev/null && echo "$1 is an integer" || \
    echo "$1 isn't an integer"

# M2: string filter
echo $1 | grep "[^0-9]" && echo "$1 isn't an integer" || \
    echo "$1 is an integer"

echo $1 | grep -v "[0-9]*" && echo "$1 isn't an integer" || \
    echo "$1 is an integer"

# M3_1: condition test
if [[ $a =~ ^[0-9]\{1,\}$ ]]; then
        echo "a is an integer;"\
else
        echo "a is not an integer"
fi
# M3_2: condition test
[[ $a =~ ^[0-9]*$ ]] && echo "a is an integer" || \
    echo "a is not an integer"

# M4_1: awk
echo $a|awk '/^[0-9]*$/{print "a is an integer"}'
# M4_2: awk
echo $a|awk '{if ($1~/^[0-9]*$/) print "a is an integer"}'

# M5: bc not support for float compute
[ $(echo $a/1 | bc) == "$a" ] && echo "It's an integer" \
    || echo "It's not an integer"
