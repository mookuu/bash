#!/bin/bash

#
# Usage of shell read
#

# Give the prompt delimeter: -p
read -p "Please enter your name:" first_name middle_name last_name
echo "First name is: $first_name"
echo "Middle name is: $middle_name"
echo "Last name is: $last_name"
echo

# Timer setting: -t [seconds]
if read -t 5 -p "Please enter your name:" name; then
        echo "Hello [$name], welcome to my script"
else
        echo "Sorry, enter too slow"
fi
echo

# Default value to: REPLY
read -p "Enter a number:"
echo "Default vaule by REPLY: $REPLY"
echo

# Limit input charaters: -n[number] or -n [number]
read -n3 -p "Input 3 character and quit."
echo
echo "character: $REPLY"
echo

# Hide input character, actually set the color of input same to the backgroud
read -s -p "Enter your passwd:" pass
echo
echo "Passwd: $pass"
echo

# Read files: read one line a time
cat $o | while read line
do
        echo $line
done

exit 0
