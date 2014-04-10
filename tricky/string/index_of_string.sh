#!/bin/bash

# Numerical position in $string of first character in $substring that matches.

string=abcABC123ABCabc
#      123456 ...

echo Using '`expr index "$string" "$substring"`' 
echo `expr index "$string" 'C12'`	# 6, all matches in [6]
echo `expr index "$string" '1c'`	# 3, c first occur in [3]
echo `expr index "$string" '1cb'`	# 2, b frist occur in [2]
echo `expr index "$string" '1AB'`	# 4, AB first occur in [4]

#  if all characters of substring matches in string, prints the first occurrance
#+ of substring, else output the last longest match position.
