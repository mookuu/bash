#!/bin/bash

#str=hello world	# error, delimeter space split the two words-->world as a command
str1="hello world"	# OK, len=11
str2="abcABC123ABCabc"	# OK, len=15

# M1:
echo Using \${#string}
echo Len1: [${#str1}]			# 11
echo Len2: [${#str2}]			# 15

# M2:
echo Using '`expr length $string`'
echo Len1: [`expr length "$str1"`]	# 11 string should be quoted, if contains blank
echo Len2: [`expr length "$str2"`]	# 15

# M3:
echo Using '`expr "$string" : '\''.*'\''`'
echo Len1: [`expr "$str1" : '.*'`]	# 11
echo Len2: [`expr "$str2" : '.*'`]	# 15
echo

exit 0
