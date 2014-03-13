#!/bin/bash

until [ -z $1 ]
do
        echo "$1"       # if parameter less than 3, then fall into endless loop
        shift 3         # it is not a parameter *copy*, but a *move*.
done

echo "$1"                       # null
echo "$2"                       # null
echo "$3"                       # null

# However, as Eleni Fragkiadaki, points out,
# attempting a 'shift' past the number of
# positional parameters ($#) returns an exit status of 1,
# and the positional parameters themselves do not change.
# This means possibly getting stuck in an endless loop. . . .
# For example:
#     until [ -z "$1" ]
#     do
#        echo -n "$1 "
#        shift 20    #  If less than 20 pos params,
#     done           #+ then loop never ends!
#
# When in doubt, add a sanity check. . . .
#           shift 20 || break
#                    ^^^^^^^^
