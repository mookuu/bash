#!/bin/bash -x

# Change to workspace quickly
home_dir="hidenori"

case $1 in
	1)
		cd  /home/$homedir/work/cs/bash # workspace 1: bash
		;;
	2)
		cd /home/$homedir/work/cs/productivity # workspace 2: productivity
		;;
	3|apue)
		cd /home/$home_dir/work/cs/apue  # workspace 3: apue
		;;
	s|S)
		cd /home/$home_dir/work/cs/schedule
		;;
	ema|emacs)
		cd /home/$home_dir/work/cs/productivity/emacs	# emacs
		;;
	md|markdown)
		cd /home/$home_dir/work/cs/productivity/markdown	# markdown
		;;
	tri|tricky)
		cd /home/$home_dir/work/cs/bash/tricky		# /bash/tricky
		;;
	int|interesting)
		cd /home/$home_dir/work/cs/bash/interesting_script	# /bash/inter*
		;;
	sch|pla|plan)
		cd /home/$home_dir/work/cs/planning
		;;
	git|github)
		cd /home/$home_dir/work/cs/productivity/github
		;;
	awk)
		cd /home/$home_dir/work/cs/bash/awk_sed/awk
		;;
	sed)
		cd /home/$home_dir/work/cs/bash/awk_sed/sed
		;;
	vi|VI|vim|VIM)
		cd /home/$home_dir/work/cs/productivity/vi
		;;
	nano|nan)
		cd /home/$home_dir/work/cs/productivity/nano
		;;
	pro)
		cd /home/$home_dir/work/cs/productivity
		;;
	page|blo|blog)
		cd /home/$home_dir/work/cs/github_pages
		;;
	*)
		cd  /home/$home_dir/work/cs/bash # workspace 1: bash
		;;
	# Other
esac


