#!/bin/bash -x

# Change to workspace quickly

case $1 in
	1)
		cd  /home/kohata/work/cs/bash # workspace 1: bash
		;;
	2)
		cd /home/kohata/work/cs/productivity # workspace 2: productivity
		;;
	3|apue)
		cd /home/kohata/work/cs/apue  # workspace 3: apue
		;;
	s|S)
		cd /home/kohata/work/cs/schedule
		;;
	ema|emacs)
		cd /home/kohata/work/cs/productivity/emacs	# emacs
		;;
	md|markdown)
		cd /home/kohata/work/cs/productivity/markdown	# markdown
		;;
	tri|tricky)
		cd /home/kohata/work/cs/bash/tricky		# /bash/tricky
		;;
	int|interesting)
		cd /home/kohata/work/cs/bash/interesting_script	# /bash/inter*
		;;
	sch|plan)
		cd /home/kohata/work/cs/schedule
		;;
	*)
		cd  /home/kohata/work/cs/bash # workspace 1: bash
		;;
esac


