#!/bin/bash

#
# Display line number of specified file
# TODO: blanks[space, tab etc.] display
#

cnt=1                           # read count

cat $0 | while read line        # read current shell's contents
do
        cnt=$cnt
        case ${#cnt} in         # length of cnt5
            1)
                echo "     $cnt	$line"
                ;;
            2)
                echo "    $cnt $line"
                ;;
            3)
                echo "   $cnt $line"
                ;;
            4)
                echo "  $cnt $line"
                ;;
            5)
                echo " $cnt $line"
                ;;
            6)
                echo "$cnnt $line"
                ;;
            *)
                echo "[Warning]: Lines above 100W, cannt display!"
                ;;
        esac
        cnt=$(($cnt+1))
done

exit 0
