#!/bin/bash

##########################
# # Array definition     #
# # 1                    #
# array=(10 20 30 40 50) #
#                        #
# # 2                    #
# array[0]=10            #
# array[1]=20            #
# array[2]=30            #
# array[3]=40            #
# array[4]=50            #
#                        #
# # 3                    #
# var="10 20 30 40 50"   #
# array=($var)           #
##########################

array=(10 20 30 40 50)

# Get member of array
echo "array[0]=${array[0]}"

# Get all the members
echo "All member:${array[@]}"
# echo ${array[*]}

# Length of array
echo "Lenght of arrays:${#array[@]}"
#echo "Lenght of arrays:${#array[*]}"

# List n length of array
echo ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
echo "Specified N member:${array[@]:0:3}" # from array[0] to 3 length of arrays
echo "Find and replace:${array[@]/0/1}"   # replace 0 wiht 1 in arrays
echo ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★

# Clear value of array[n]
unset array[1]
echo "Now all member:${array[@]}"
echo "Now length of arrays:${#array[@]}"

# Delete entire array
unset array
echo "Now all member:${array[@]}"
echo "Now length of arrays:${#array[@]}"
