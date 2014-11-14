#!/bin/bash
#
# short-circuit in &&, ||, -a, -o(within single barckets)
# Conclusion: use
#             [ condition1 ] && [ condition2 ]
#             [[ condition1 && condition 2 ]]
#             []

[ 1 -eq 1 ] && [ -n "`echo test 1>&2`" ]
# Result: test, short-circuit OK
[ 1 -eq 2 ] && [ -n "`echo test 1>&2`" ]
# (no output), short-circuit OK

[ 1 -eq 2 -a -n "`echo test 1>&2`" ]	# Wrong result
# Result: test, short-circuit NG

[[ 1 -eq 2 && -n "`echo test 1>&2`" ]]
# (no output), short-circuit OK
# Apparently && and || "short-circuit" while -a and -o do not.
