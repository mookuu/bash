#!/bin/bash

#
#  Generate random integers within a range

#  M1
#  Generate random number between 6 and 30.
r_number=$((RANDOM%25+6))

#  M2
#  Generate random number in the same 6 - 30 range,
#+ but the number must be evenly divisible by 3.
r_number=$(((RANDOM%30/3+1)*3))

#  Note that this will not work all the time.
#  It fails if $RANDOM%30 returns 0.

#  M3
#  Frank Wang suggests the following alternative:
r_number=$(( RANDOM%27/3*3+6 ))

#  M4: not recommanded
r_number=$(((RANDOM%(max-min+divisibleBy))/divisibleBy*divisibleBy+min))
