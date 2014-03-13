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

# M4: clear file's contents
: > data.xxx   # File "data.xxx" now empty.
# Same effect as   cat /dev/null >data.xxx
# However, this does not fork a new process, since ":" is a builtin.


# M5: use to begin a comment line(not recommended),
# Using # for a comment turns off error checking for the remainder of that line,
# so almost anything may appear in a comment. However, this is not the case with :.
: This is a comment that generates an error, ( if [ $x -eq 3] ).

# M6: serves as a filed separator, in /etc/passwd and in the $PATH variable
echo $PATH
/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
# TODO: PATH add

# M7: use as a function name(not portable, not recommended)
:()
{
  echo "The name of this function is "$FUNCNAME" "
  # Why use a colon as a function name?
  # It's a way of obfuscating your code.
}

:
# The name of this function is :

# M8: Placeholder in an oherwise empty function
not_empty ()
{
  :
} # Contains a : (null command), and so is not empty.
