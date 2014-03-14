#!/bin/bash -x
test_char ()
{
case "$1" in
    [[:print:]] ) echo "$1 is a printable character.";;&
    [[:alnum:]] ) echo "$1 is an alpha/numeric character.";;& # v
[[:alpha:]] ) echo "$1 is an alphabetic character.";;& # v
[[:lower:]] ) echo "$1 is a lowercase alphabetic character.";;&
[[:digit:]] ) echo "$1 is an numeric character.";& # |

%%%@@@@@ ) echo "********************************"
            ;; # v

esac
}
