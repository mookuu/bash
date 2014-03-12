#!/bin/bash

# null command [colon].
# This is the shell equivalent of a "NOP" (no op, a do-nothing operation).
# The":" command is itself a Bash builtin, and its exit status is true (0).

# M1: true, endless loop
while :
do
        :
done

# same as
while true
do
        operation-1
        operation-2
        ...
        operation-n
done

# M2: Placeholder
if condition; then
    :
else
    take-some-action
fi

# M3:
