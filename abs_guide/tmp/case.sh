#!/bin/bash

rad val
case $val in
	Y|y)
		echo "yes"
		;;
	N|n)
		echo "no"
		;;
	*)
		echo "incorrect input"
		;;
esac

exit 0
