#!/bin/bash

# Name of current function
#
func(){
	echo "$FUNCNAME now executing."		# func now executing
}

func

echo "FUNCNAME = $FUNCNAME"		# FUNCNAME =
					# Null value outside a function

