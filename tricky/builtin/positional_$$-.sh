#!/bin/bash

# Flags passed to script (using set). See Example 15-16.

# tively, the script can test for the presence of option "i" in the $- flag.
case $- in
	*i*)    # interactive shell
		;;
	*)      # non-interactive shell
		;;
esac
# (Courtesy of "UNIX F.A.Q.," 1993)
