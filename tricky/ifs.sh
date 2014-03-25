#!/bin/bash

#
# Set Internal Field Separator(IFS)

var1="a+b+c"
var2="d-e-f"
var3="h,i,j"

IFS="+"                           # IFS is "+"

echo "========================================================"
echo $var1
echo $var2
echo $var3

IFS="-"                           # IFS is "-"

echo "========================================================"
echo $var1
echo $var2
echo $var3

IFS=","

echo "========================================================"
echo $var1
echo $var2
echo $var3

# However ...
# $IFS treats whitespace differently than other characters.

output_args_one_per_line()
{
        for arg
        do
                echo "[$arg]"
        done #  ^    ^   Embed within brackets, for your viewing pleasure.
}

echo
echo "========================================================"
echo "IFS=\" \""

IFS=" "

var=" a  b c   "
output_args_one_per_line $var  # output_args_one_per_line `echo " a  b c   "`
# [a]
# [b]
# [c]


echo
echo "========================================================"
echo "IFS=:"

IFS=:
var=":a::b:c:::"               # Same pattern as above,
#    ^ ^^   ^^^                #+ but substituting ":" for " "  ...
output_args_one_per_line $var
# [], separator delimit 2 parameters, so A NULL before first :
# [a]
# [], same as above, A NULL between a and :(which right after a)
# [b]
# [c]
# [], same as above, A NULL between c and :(which right after c)
# [], same as above, A NULL between : and :(last second one)
# last : delimit nothing, same as " a b c "

# Note "empty" brackets.
# The same thing happens with the "FS" field separator in awk.


echo

exit
