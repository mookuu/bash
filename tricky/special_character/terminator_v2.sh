#!/bin/bash

test_char ()
{
        case "$1" in
            [[:print:]] )
                echo "$1 is a printable character."
                ;;&             # The ;;& terminator continues to the next pattern test.
            [[:alnum:]] )
                echo "$1 is an alpha/numeric character."
                ;;&
            [[:alpha:]] )
                echo "$1 is an alphabetic character."
                ;;&
            [[:lower:]] )
                echo "$1 is a lowercase alphabetic character."
                ;;&
            [[:digit:]] )
                echo "$1 is an numeric character."
                ;&              # The ;& terminator executes the next statement ...
            %%%@@@@@    )
                echo "********************************"
                ;;
                # with a dummy pattern.
        esac
}
