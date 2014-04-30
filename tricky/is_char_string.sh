#!/bin/bash

[ "$1" -eq 0 ] 2>/dev/null
if [ $? -ge 2 ]; then
	echo "string"
else
	echo "char or integer"
fi
