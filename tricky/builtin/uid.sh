#!/bin/bash

#
# User ID number, recorded in /etc/passwd Current user's real id, even
# if temporarily assumed another identify through su
# Readonly variable, cann't change through CLI or within a script
# a counterpart to the id builtin
# $UID

# M1
ROOT_UID=0

if [ "$UID" -eq "$ROOT_UID" ]; then
	echo "Root"
else
	echo "Ordinary user"
fi

exit 0

# M2
ROOT_USER=root

user_name=`logname`	# real log name
# user_name=`whoami`	# current user name(if assume with su, then root)
# user_name=`id -nu`	# current user name(if assume with su, then root)

if [ "$user_name" = "$ROOT_USER"  ]; then
	echo "Root"
else
	echo "Oridinary user"
fi
