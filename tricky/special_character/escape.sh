#!/bin/bash

#
# escape may mean different meaning in ECHO | SED
#

# Special meaning: with $'xx' format
echo ✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦
echo before newline
echo $'\n'                      # newline
echo after newline              # newline*2: '\n' + echo(default newline if without -n)
echo beep or flash$'\a'

# $'\0nn' format, 0nn-->octal; xnn->hex
echo ✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦
a=$'\061'
echo $a                         # now a = 1
b=$'\x31'
echo $b                         # now b = 1
c="\061"
echo -e $c

# escape newline
echo ✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦
echo  "the first line
the second line"

echo "this will print \
as one line"                    # escapes the newline

# newlines
echo line1; echo line2
echo line3

# Escape's meaning in ECHO and SED: default escaped(output character literally)
echo ✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦
echo \v\v\v                     # vvv --> literally output; not escaped
echo "\v\v\v"                   # \v\v\v --> fully quotation
echo '\v\v\v'                   # \v\v\v --> fully quotation
# -e: enable interpretation of backslash escapes
echo -e "\v\v\v"                # vertical tab
echo -e '\v\v\v'                # vertical tab
echo -e 1234'\v\v\v'5           # waht out the position of numbers-->vertical tab
echo -e "\061"

#
echo ✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦
echo "Introducing the \$'\ ... \' string-expansion construct . . . "
echo $'\t \042 \t'

echo "\' '"

echo ''\'''                     # single ' is unmatched, so \ to escape literally
echo ''"'"''                    # same as 2 ' == "
