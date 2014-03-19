#!/bin/bash

# Change to workspace quickly

case $1 in
	1)
		cd  /home/kohata/work/cs/bash # workspace 1: bash
		;;
	2)
		cd /home/kohata/work/cs/emacs # workspace 2: emacs
		;;
	3)
		cd /home/kohata/work/cs/apue  # workspace 3: apue
		;;
	*)
		cd  /home/kohata/work/cs/bash # workspace 1: bash
		;;
esac


