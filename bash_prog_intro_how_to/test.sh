#!/bin/bash

var=2000
function drawper ()
{
        _per=`expr $1 \* 100 / $2` # (value)%$2
        case `expr $_per / 4 % 4` in
            0) _char="|" ;;
            1) _char="/" ;;
            2) _char="-" ;;
            3) _char="\\" ;;
        esac

        printf "\r$_char $_per%%"
        if [ $1 -eq $2 ];then
                printf "\n"
        fi
}

i=1
while [ $i -le $var ]
do
        drawper $i $var
        i=`expr $i + 1`
done
