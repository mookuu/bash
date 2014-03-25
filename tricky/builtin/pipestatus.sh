#!/bin/bash

#
# Array variable holding exit status(es) of last executed foreground 
# pipe

# The members of the $PIPESTATUS array hold the exit status of each 
# respective command executed in a pipe. 
# $PIPESTATUS[0] holds the exit # status of the first command in the pipe,
# $PIPESTATUS[1] the exit # status of the second command, and so on.

echo $PIPESTATUS

ls -al | bogus_command

echo ${PIPESTATUS[0]}

ls -al | bogus_command
echo ${PIPESTATUS[1]}

ls -al | bogus_command
echo $?

echo "======================================================"
echo

ls -al | bogus_command | wc

echo ${PIPESTATUS[@]}
# 141 127 0
# If ls writes to a pipe whose output is not read, then SIGPIPE kills 
# it, and its exit status is 141. Otherwise its exit status is 0, as 
# expected. This likewise is the case for tr.
