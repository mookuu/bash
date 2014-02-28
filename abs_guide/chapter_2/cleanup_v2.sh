#!/bin/bash
# Proper Header for a Bash Script

# Clean up, version 2.

# Run as root, of course.
# Insert here to print error message and exit if not root.

LOG_DIR=/var/log
# Variables are better than hard-coded variables.
cd $LOG_DIR

cat /dev/null > messages
cat /dev/null > wtmp

echo "Log files cleaned up."

exit         # The right and proper method of "exiting" from a script.
             # A bare "exit" (no parameter) returns the exit status
             # of the preceding command.
