#!/bin/bash

#
# Firmware created automatically.
#
# Usage:
#   rom DVR | dvr
#   rom CNV | cnv
#   rom 1CH | 1ch
#   rom FULLHD | fullhd | FH | fh
#   rom HUB | hub
#

# TODO: popup when exit

# errno
DIR_WRONG=129
ERR_MAKE=130
ERR_UNKNOWN=131

sudo ls > /dev/null
# Parameter check
[ -z $1 ] && echo "[Warning]: Parameter error, plz specify whcih firmware u want to generate."

# If not in the right /apl directory
path=$`pwd`
if [ ${path##*/} != apl ]; then
        echo "[Warning]: Wrong diretory! Plz change to the '/apl' directory and excute shell agian!"
        exit $DIR_WRONG
else
        path1=${path%/apl}
        path2=${path1##*/}
        if [ $path2 != $1 ]; then
                echo "[Warning]: Wrong directory! Specified $1 but in $path2's directory!"
                exit $DIR_WRONG
        fi
fi


# Change code format in case of UTF8
sudo chmod -R 766 .
[ ./NKF euc-jp 2>/dev/null ] && echo "Code conversation successfully" || echo "[Error]: Code conversation failed!"

case $1 in
    dvr|DVR)
        ./Build.sh config DVR 2&>1
        ./Build.sh set ../../CAM/apl 2&>1
        ./Build.sh copy 2&>1
        sudo ./mkallrom.sh DVR 2&>1 # what about the warning msg
        if [ $? -ne 0 ]; then
                echo "[Error]: error happened when make rom."
                exit ERR_MAKE
        else
                echo "$1\'s frimware generated succuessfully."
        fi
        ;;
    cnv|CNV)
        ./Build.sh config CNV 2&>1
        ./Build.sh set ../../CAM/apl 2&>1
        ./Build.sh copy 2&>1
        sudo ./mkallrom.sh CNV 2&>1 # what about the warning msg
        if [ $? -ne 0 ]; then
                echo "[Error]: error happened when make rom."
                exit ERR_MAKE
        else
                echo "$1\'s frimware generated succuessfully."
        fi
        ;;
    1CH|1ch)
        ./Build config 1Ch
        ./Build target ALL
        ./Build all
        if [ $? -ne 0 ]; then
                echo "[Error]: error happened when make rom."
                exit ERR_MAKE
        else
                echo "$1\'s frimware generated succuessfully."
        fi
        cd mkrom
        sudo ./makerom.sh
        ;;
    FULLHD|fullhd|FH|fh)
        ./Build config FULLHD
        ./Build target ALL
        ./Build all
        if [ $? -ne 0 ]; then
                echo "[Error]: error happened when make rom."
                exit ERR_MAKE
        else
                echo "$1\'s frimware generated succuessfully."
        fi
        cd mkrom
        sudo ./makerom.sh
        ;;
    HUB|hub)
        ./BUILD.sh set_cam ../../CAM/apl/
        ./BUILD.sh set_dvr ../../DVR/apl/
        ./BUILD.sh copy
        ./BUILD.sh all
        if [ $? -ne 0 ]; then
                echo "[Error]: error happened when make rom."
                exit ERR_MAKE
        else
                echo "$1\'s frimware generated succuessfully."
        fi
        cd ./mkrom
        sudo ./makerom.sh
    *)
        echo "ROM name error, plz specifiy again!"
        exit ERR_UNKNOWN
        ;;
esac

exit 0
