#!/bin/bash

LOG=$0.log

COMMAND1="sleep 100"

echo >> "$LOG"

echo "Logging PIDs background commands for script: `basename $0`" >> "$LOG"
# So they can be monitored, and killed as necessary.

# Logging commands.

echo -n "PID of \"$COMMAND1\":  " >> "$LOG"
${COMMAND1} &

echo $! >> "$LOG"
echo "Pid of `basename $0`: $$" >> "$LOG"
# PID of "sleep 100":  1506

# Thank you, Jacques Lederer, for suggesting this.
