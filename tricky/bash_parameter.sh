#!/bin/bash

#
# bash parameter

# Last execution or shell exit status, O if OK.--> return code
$?

# Parameter count
$#

# All variables, eg "$1", "$2", "$3"... every parameter is independent
# "$@" should be quoted or not
# Usage:
# M1: for val in "$@"	# seperate words
# M2: echo "$@"		# single word
$@

# All varialbes, seen as single word, eg "$1, $2, $3..."
# "$*" must be quoted
# if not, same as $@
# Usage:
# M1: for val in "$*"	# single word
# M2: for val in $*	# seperate words
$*

# When shell start or set option
$-

# PID of the script itself. Even inside a subshell, it returns parent PID
$$

# Current sheel name
$0

# Parameter position
$n

# PID of last job running in background
$!

# Special variable (which is)set to final argument of previous command executed
$_
