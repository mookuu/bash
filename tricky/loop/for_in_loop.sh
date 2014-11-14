#!/bin/bash
#
# trickys in for loop

function func() {
	for element in $1/*; do
		echo "file: $element"
	done
}

# $#, parameter numbers
# $@, seperate parameters from CLI
[ $# -eq 0 ] && directorys=`pwd` || directorys=$@

for directory in $directorys; do
	if [ -d $directory ]; then
		echo "directory: $directory"
		# function here
		func $directory
	else
		echo "not directory"
	fi
done
