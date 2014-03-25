#!/bin/bash

#
# bash parameter

# Last execution or shell exit status, O if OK.--> return code
$?

# Parameter count
$#

# All variables, eg "$1", "$2", "$3"... every parameter is independent
$@

# All varialbes, eg "$1, $2, $3..."
$*

# When shell start or set option
$-

# Current shell pid
$$

# Current sheel name
$0

# Parameter position
$n
