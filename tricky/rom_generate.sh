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
ERR_NOROM=128
DIR_WRONG=129
ERR_MAKE=130
ERR_UNKNOWN=131

sudo ls > /dev/null
# Parameter check
[ -z $1 ] && echo "[Error]: Parameter error! Plz specify whcih firmware u want to generate." && exit $ERR_NOROM


# If not in the right /apl directory
path=$`pwd`
path1=${path%/apl}
path2=${path1##*/}
if [ ${path##*/} != apl ]; then
        echo "[Error]: Wrong diretory! Plz change to the '/apl' directory and excute shell agian!"
        exit $DIR_WRONG
fi

function dir_chk()
{
	if [ $path2 != $1 ]; then
                echo "[Error]: Wrong directory! Specified $1 but in $path2's directory!"
                exit $DIR_WRONG
        fi
}


# Change code format in case of UTF8
sudo chmod -R 777 .
# TODO: follow one desn`t work, why???
# [ sudo ./NKF.sh euc-jp ] && echo "Code conversation successfully" || echo "[Error]: Code conversation failed!"
# ./NKF.sh euc-jp 2 > 1
if sudo ./NKF.sh euc-jp 2&>1; then
	echo "Code conversation succeed"
else
	echo "[Error]: Code conversation failed"
fi
# TODO: all file in DVR CAM HUB should converse code




case $1 in
    dvr|DVR)
	dir_chk DVR
        ./BUILD.sh config DVR | 2&>1
	echo "./BUILD.sh config DVR succeed"
        ./BUILD.sh set ../../CAM/apl | 2&>1
	echo "./BUILD.sh set ../../CAM/apl succueed"
        ./BUILD.sh copy | 2&>1
	echo "./BUILD.sh copy succeed"
        sudo ./mkallrom.sh DVR | 2&>1 # what about the warning msg
        if [ $? -ne 0 ]; then
                echo "[Error]: error happened when execute ./makeallrom.sh DVR"
                exit $ERR_MAKE
        else
		echo "sudo ./mkallrom.sh DVR succeed"
                echo "DVR frimware generated succuessfully"
        fi
        ;;
    cnv|CNV)
	dir_chk DVR
        ./BUILD.sh config CNV | 2&>1
	echo "./BUILD.sh config CNV susseed"
        ./BUILD.sh set ../../CAM/apl | 2&>1
	echo "./BUILD.sh set ../../CAN/apl succeed" 
        ./BUILD.sh copy | 2&>1
	echo "./BUILD.sh copy succeed"
        sudo ./mkallrom.sh CNV | 2&>1 # what about the warning msg
        if [ $? -ne 0 ]; then
		echo "[Error]: error happened when make rom"
                exit $ERR_MAKE
        else
		echo "sudo ./mkallrom.sh CNV succeed"
                echo "CNV frimware generated succuessfully"
        fi
        ;;
    1CH|1ch)
	dir_chk CAM
        ./BUILD.sh config 1CH | 2&>1
	echo "./BUILD.sh config 1Ch succeed"
        ./BUILD.sh target ALL | 2&>1
	echo "./BUILD.sh target ALL succeed"
        ./BUILD.sh all | 2&>1
        if [ $? -ne 0 ]; then
                echo "[Error]: error happened when ./BUILD.sh all"
                exit $ERR_MAKE
        else
		echo "./BUILD.sh all succeed"
	fi
	cd mkrom | 2&>1
	sudo ./makerom.sh | 2&>1
	if [ $? -ne 0 ]; then
		echo "[Error]+ error happened when make rom"
		exit $ERR_NAME
	else
        	echo "CAM_1CH frimware generated succuessfully"
	fi
        ;;
    FULLHD|fullhd|FH|fh)
	dir_chk CAM
        ./BUILD.sh config FULLHD | 2&>1
        ./BUILD.sh target ALL | 2&>1
        ./BUILD.sh all | 2&>1
        if [ $? -ne 0 ]; then
                echo "[Error]: error happened when ./BUILD.sh all"
                exit $ERR_MAKE
        else
                echo "CAM_FULLHD frimware generated succuessfully"
        fi
        cd mkrom | 2&>1
        sudo ./makerom.sh | 2&>1
        if [ $? -ne 0 ]; then
                echo "[Error]+ error happened when make rom"
                exit $ERR_NAME
        else
                echo "CAM_1CH frimware generated succuessfully"
        fi
        ;;
    HUB|hub)
	dir_chk HUB
        ./BUILD.sh set_cam ../../CAM/apl/ | 2&>1
        ./BUILD.sh set_dvr ../../DVR/apl/ | 2&>1
        ./BUILD.sh copy | 2&>1
        ./BUILD.sh all | 2&>1
        if [ $? -ne 0 ]; then
                echo "[Error]: error happened when make rom."
                exit $ERR_MAKE
        else
                echo "HUB frimware generated succuessfully."
        fi
        cd ./mkrom | 2&>1
        sudo ./makerom.sh | 2&>1
        if [ $? -ne 0 ]; then
                echo "[Error]+ error happened when sudo ./makerom.sh"
                exit $ERR_NAME
        else
                echo "HUB frimware generated succuessfully"
        fi
	;;
    *)
        echo "ROM name error, plz specifiy again!"
        exit $ERR_UNKNOWN
        ;;
esac

exit 0
