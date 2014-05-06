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
	sch|pla|plan)
		cd /home/kohata/work/cs/planning
		;;
	git|github)
		cd /home/kohata/work/cs/productivity/github
		;;
	awk)
		cd /home/kohata/work/cs/bash/awk_sed/awk
		;;
	sed)
		cd /home/kohata/work/cs/bash/awk_sed/sed
		;;
	vi|VI|vim|VIM)
		cd /home/kohata/work/cs/productivity/vi
		;;
	nano|nan)
		cd /home/kohata/work/cs/productivity/nano
		;;
	pro)
		cd /home/kohata/work/cs/productivity
		;;
	page|blo|blog)
		cd /home/kohata/work/cs/github_pages
		;;
	*)
		cd  /home/kohata/work/cs/bash # workspace 1: bash
		;;
	# Other
esac


