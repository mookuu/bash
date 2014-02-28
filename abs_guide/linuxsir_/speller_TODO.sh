#!/bin/bash
# Script name: Speller
#
#
# Purpose: Check and fix spelling errors in a file
#

exec < tmp   # opens the tmp file
while read line  # read from the tmp file
do
print $line
print -n "Is this word correct? [Y/N] "
read answer < /dev/tty  # read from the terminal
    case $answer in
    [Yy]*)
        continue
            ;;
    *)
        print "New word? "
        read word < /dev/tty
        sed "s/$line/$word/" tmp > error
        mv error tmp
        print $word has been changed.
            ;;
    esac
done
