#!/bin/bash


#  The "greatest common divisor" (gcd) of two integers
#  is the largest integer that will divide both, leaving no remainder.

#  Euclid's algorithm uses successive division.
#    In each pass,
#       dividend <---  divisor
#       divisor  <---  remainder
#    until remainder = 0.
#    The gcd = dividend, on the final pass.

ARGS=2
E_BADARGS=85
E_NOINTEGER=86

# Parameter check
# parameter chk 1: 2 paramter
if [[ $# -ne "$ARGS" ]]; then
        echo "Usage: `basename $0` number1 number2"
        exit $E_BADARGS
fi

# TODO: parameter chk2: integer


function gcd() {
        local dividend=$1
        local divisor=$2

        local remainder=1             # in case of null parameter

        until [ "$remainder" -eq 0 ]
        do
                let "remainder = $dividend % $divisor"
                dividend=$divisor
                divisor=$remainder
        done
}

gcd $1 $2

echo
echo "GCD of $1 and $2 = $dividend"
echo

exit
