#!/bin/bash
# test if command exists

command_test () { type "$1" &>/dev/null; }
#

cmd=rmdir
# Legitimate command.
command_test $cmd; echo $?
# 0
cmd=bogus_command
# Illegitimate command
command_test $cmd; echo $?
# 1

