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

# M2_1: Placeholder
if condition; then
    :                           # Do nothing and branch ahead
else                            # Or else
    take-some-action
fi

# M2_2: placeholder where a binary operation is expected
: ${username=`whoami`}
# ${username=`whoami`}   Gives an error without the leading :
#                        unless "username" is a command or builtin...

: $((n = $n + 1))
# ":" necessary because otherwise Bash attempts
# to interpret "$((n = $n + 1))" as a command.

(( n = n + 1 ))
# A simpler alternative to the method above.
# Thanks, David Lombard, for pointing this out.

# M2_3: placeholder where a command is expected
# HERE DOCUMENT
: <<TESTVARIABLES
${HOSTNAME?}${USER?}${MAIL?}  # Print error message if one of the variables not set.
TESTVARIABLES
# Same as
# cat <<EOF
# EOF

# M3: Evaluate string of variables
: ${HOSTNAME?} ${USER?} ${MAIL?}
# Prints error message
# If one or more of essential environmental variables not set.
