#!/bin/bash

# Definitaion of arrays
# M1
array={10 20 30 40 50}

# M2
array[0]=10
array[1]=20
array[2]=30
array[3]=40
array[4]=50

# M3
var="10 20 30 40 50"
array=($var)


# Output specify element
echo ${array[i]}	# start from 0


# Output all elements
# M1
echo ${array[@]}

# M2
echo ${array[*]}


# Length of array
# M1
echo ${#array[@]}

# M2
echo ${#array[*]}


# Delete specify element
unset array[i]	# TODO:


# Delete entire array
unset array


# Output specify element(range)
echo ${array[@]:0:3}	# output 1 2 3
# 0: start position
# 3: length


# Replace
echo ${a[@]/0/1}	# replace 0 with 1
# 0: character which wanna be replaced
# 1: replacement character

