#!/bin/bash
#
# translate octal/hex to ascii character
# M1: $'\nnn' $'\xhhh'
# M2: echo -e "\nnn"  echo -e "\xhhh"
# The $'\X' construct makes the -e option unnecessary
# priority: $''>echo -e

echo $'\042'	# ":
echo -e "\042"	# ": -e enable interpretation of backslah escape

echo $'\n'	# newline

