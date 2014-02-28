#!/bin/bash

echo -n "r u female(Y/N)?"

read val

case $val in
    Y|y)
        echo "yes"
        ;;
    N|n)
        echo "no"
        ;;
    *)
        echo "other"
        ;;
esac
