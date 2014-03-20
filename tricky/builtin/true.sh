#!/bin/bash


true    # The "true" builtin.
echo "exit status of \"true\" = $?"   # 0

! true                                # builtin, logical not qualifier
echo "exit status of \"! true\" = $?" # 1

# =========================================================== #
# Preceding a _pipe_ with ! inverts the exit status returned.
ls | bogus_command     # bash: bogus_command: command not found
echo "exit code: $?"   # 127

! ls | bogus_command   # bash: bogus_command: command not found
echo "exit code: $?"   # 0
# Note that the ! does not change the execution of the pipe.
# Only the exit status changes.
# =========================================================== #

# Thanks, Stéphane Chazelas and Kristopher Newsome.
