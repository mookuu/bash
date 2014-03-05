#!/bin/bash

# i=3*(5+2)
# M1: (())
val1=$((3*(5+2)))
((val1++))
val11=$[3*$[5+2]]
echo "val1=$val1"
echo "val11=$val11"

# M2: let
let "val2=3*(5+2)"
let "val2++"
echo "val2=$val2"

# M3: expr
val3=`expr 3 \* \( 5 + 2 \)`
val3=`expr $val3 + 1`
echo "val3=$val3"

# M4: bc
val4=`echo "3*(5+2)"| bc`
val4=`echo "$val4+1"| bc`
# floating calculate
val5=`echo "scale=3; 1/3"| bc -l`
echo "val4=$val4"
echo "val5=$val5"
