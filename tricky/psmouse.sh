#!/bin/bash

#
# forbidden psmouse
#

# Default enable psmouse
[ -z $1 ] && sudo modprobe psmouse && exit 0

case $1 in
	0)
		# disable psmouse
		sudo modprobe -r psmouse
		# M2:
		# sudo rmmod psmouse
		exit 0
		;;
	*)
		# enable psmouse
		sudo modprobe psmouse
		exit 0
		;;
esac
