#!/bin/bash

#
# Exit status test
# Condition test command
# []
# [[...]]   eg: [[ $a -lt $b ]]
#
# Assignment can also use for test
# return TRUE(0) if the value in assingment is non-zero/true
# else return FALSE(1)
# (()) -->0/1
# let ...  -->0/1
# The (( )) construct expands and evaluates an arithmetic expression.
# If the expression evaluates as zero, it returns an exit status of 1, or "false".
# A non-zero expression returns an exit status of 0, or "true".
#

(( 0 && 1 ))                 # Logical AND
echo $?     # 1     ***
# And so ...
let "num = (( 0 && 1 ))"
echo $num   # 0
# But ...
let "num = (( 0 && 1 ))"
echo $?     # 1     ***


(( 200 || 11 ))              # Logical OR
echo $?     # 0     ***
# ...
let "num = (( 200 || 11 ))"
echo $num   # 1
let "num = (( 200 || 11 ))"
echo $?     # 0     ***


(( 200 | 11 ))               # Bitwise OR: 0|1->1 1|1->1
echo $?                      # 0     ***
# ...
let "num = (( 200 | 11 ))"
echo $num                    # 203
let "num = (( 200 | 11 ))"
echo $?                      # 0     ***

let "num = (( 200 | 100 ))"
echo $num                      # 0     ***


# The "let" construct returns the same exit status
#+ as the double-parentheses arithmetic expansion.
var=-2 && (( var+=2 ))
echo $?                   # 1

echo "start"
var=-2 && (( var+=2 )) && echo $var
                          # Will not echo $var!
echo "end"

# The very useful "if-grep" construct:
# -----------------------------------
if grep -q pdarentheses $0; then
        echo "File contains at least one occurence of parentheses."
else
        echo "pattern not matched."
fi


word=Linux
letter_sequence=inu
if echo "$word" | grep -q "$letter_sequence"
# The "-q" option to grep suppresses output.
then
  echo "$letter_sequence found in $word"
else
  echo "$letter_sequence not found in $word"
fi

if COMMAND_WHOSE_EXIT_STATUS_IS_0_UNLESS_ERROR_OCCURRED
  then echo "Command succeeded."
  else echo "Command failed."
fi
