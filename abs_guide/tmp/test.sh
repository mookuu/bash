#!/bin/bash

var=

echo "var=$var"

if [ -z "$var" ]; then
	echo "szie zero, unitialization"
else
	echo "size not zero"
fi
