#!/bin/bash

# Usage:
# 1) bkup mode
# 2) Update files.
# TODO: backup folder recursive.
# TODO: authority root?

# Parameter
# ` `
SCRIPT_NAME="my_bkup.sh"
LIST_FILE="list_file.txt"
BKUP_SRC_PATH="/home/gemini/resource/"
BKUP_PATH_COMMON="/home/ryan/Documents/bkup_customize/"
BKUP_PATH_DEFAULT="/home/ryan/Documents/bkup_default/"
UPDATE_PATH_SRC="/home/ryan/Downloads/"
UPDATE_PATH_DST=$BKUP_SRC_PATH

BOOK1="abs-guide.pdf"
BOOK2="fhs-2.3.pdf"
BOOK3=".chm"
BOOK1_LEN=`expr length $BOOK1`
FILE_TO_UPDATE1=".pdf"
FILE_TO_UPDATE2=".chm"
#CUR_DIR=`ls`

update_main_func()
{
    cd $1 && CUR_DIR=`ls`
    echo "[DBG]: Current directory: $PWD"

    for val in $CUR_DIR
    do
        if [ -f $val ]; then
            # Update .pdf && .chm file only
            if [[ $val == *${FILE_TO_UPDATE1} ]] ||
                [[ $val == *${FILE_TO_UPDATE2} ]]; then
                # TODO: update file by timestamp
                cp -v $val $UPDATE_PATH_DST
            else
                echo "Warning: $val will not be updated."
            fi
        else
            echo "Warning: $1 nothing to update now."
        fi
    done
}

# Make directory and backup files
bkup_main_func_exec()
{
    local src_path=$1
    local dst_path=$2

    if [ -f $src_path ]; then
        if [ -d $dst_path ]; then
            # if default folder
            if [ ${BKUP_PATH_DEFAULT} == ${dst_path} ]; then
                if [ ! -d $dst_path`date +%Y%m%d%H%M%S` ]; then
                    mkdir $dst_path`date +%Y%m%d%H%M%S`
                fi
                # use the date to get default folder
                dst_path=$dst_path`date +%Y%m%d%H%M%S`
                echo "[DBG]: Default folder extenssion: $dst_path"
            fi
            cp -v $src_path $dst_path
        else
            mkdir $dst_path
            cp -v $src_path $dst_path
        fi
    else
        # TODO: get line number of current shell
        echo "Error, $src_path not exists!"
    fi
}

bkup_main_func()
{
    local line_no=0             # file's line number
    # echo "DBG: parameter from main para1:[$0], para2:[$1] para3[$2]"

    # cat $LIST_FILE | while read -r line_content
    # pass the list file by parameter2
    while read -r line_content
    do
        let line_no=`expr $line_no + 1` # File's line number
        if [ `expr match $line_content $BOOK1` == "$BOOK1_LEN" ] || # expr: serach substring from str
            [ ${line_content} == ${BOOK2} ] || # string comparasion
            [[ ${line_content} == *${BOOK3} ]]; then # regular expression
            # echo "File<$line_content> found!"
            src_path=$BKUP_SRC_PATH$line_content # bkup file's full path
            if [ x$2 == x ]; then
                dst_path=$BKUP_PATH_DEFAULT # if not specify bkup folder, use the default
                echo "[DBG]: Default folder: path $dst_path"
            else
                dst_path=$BKUP_PATH_COMMON$2 # else the customized one
                echo "[DBG]: Customize folder: $dst_path"
            fi
            # mkdir && copy
            bkup_main_func_exec $src_path $dst_path
        else
            echo "$PWD$SCRIPT_NAME[L$line_no]: Error, <$line_content> doesn't exist!"
        fi
    done < $LIST_FILE
}


# Backup main function
main()
{
    # Parameter passed by script
    # TODO:

    # List file contains files that will be backup
    if [ ! -e "$LIST_FILE" ]; then
        echo "Error! List file doesn't exist."
        exit 1
    fi

    # call backup function
    case $1 in
        /)
            #/adsaf(
            # TODO: Get the first character(/) from the entire folder name
            # tmp=`cat ${$1} | awk '{print $1}'`
            echo "[DBG]: Backup folder's name can't start with $1"
            ;;
        a)
            echo here
            ;;
        # BUG1: ./bkup.sh #
        \?|@|\#|\;|/|\||$|%$|\&|\<|\>|\'|\")
            echo "[DBG]: Specifial characters should be avoid in shell"
            ;;
        r|R)
            echo "[DBG]: Update mode."
            # update files
            update_main_func $UPDATE_PATH_SRC && exit 0
            ;;
        b|B)
            echo "[DBG]: Bkup mode(default)."
            # echo -e "\n\n test newline"
            # backup files
            bkup_main_func $LIST_FILE $1 && exit 0
            ;;
        esac
}

# Usage added
if [ $# -lt 2 ]; then
        echo "usage:"
        echo "$0 [r|R] files|directory"
        echo "    restore files or directory"
        echo "$0 [b|B] files|directory "
        echo "    backup files or directory"
        exit 0
else
        main $1 $2
fi
