#!/bin/bash

# This shell renames sufix of files in the specified folder
# USAGE: rename_sufix.sh path

#script start
function dir_file_rename()
{
        echo [DBG]: rename directory
        # get absolute of files
        if [ a${1%%/*} != a ]; then # if relative path
                # case of directory: test | test/ | test/test | test/test/
                # ./test | ./test/ | ./test1/test2 | ./test1/test2/
                # ../test | ../test/ | ../test1/test2 | ../test1/test2/
                CUR_DIR_PATH=$PWD/${1}
        else                           # if absolute path
                CUR_DIR_PATH=$1
        fi
        # check if directory contains / in the end
        if [ a${1##*/} != a ]; then
                CUR_DIR_PATH=$CUR_DIR_PATH/ # add / to the end of directory
        fi
        # echo [DBG]: [\$1]: $1
        cd $CUR_DIR_PATH && CUR_DIR_FILE=`ls`
        for val in $CUR_DIR_FILE
        do
                echo [DBG]: directory file: $val
                if [ -e $val ]; then
                        # echo [DBG]: come here 1
                        # echo [DBG]: parameter0 is:$0
                        # echo [DBG]: directory file path: $CUR_DIR_PATH$val
                        # cd /home/gemini/workspace/cs/bash/abs_guide/tmp && $0 $CUR_DIR_PATH$val # recursive
                        $0 $CUR_DIR_PATH$val # recursive
                        if [ $? == 0 ]; then
                            echo [DBG]: [$val] rename OK
                            echo [DBG]: return value: [$?]
                            echo "-------------------------------------"
                        else
                            echo [DBG]: rename NG
                            echo [DBG]: return value: [$?]
                            echo "-------------------------------------"
                        fi
            else
                echo Warning: come here 4, [$val] is not a file
            fi
        done
}



function resume_file()
{
        echo [DBG]: resume files
        if [ ! -z $2 ]; then
                if [ ! -d $2 ]; then
                        echo [DBG]: restore file resource path: ${2%/*}
                        cat ${2%/*}/.rename.sufix.bin | while read -r line
                        do
                                echo [DBG]: file restore
                                echo [DBG]: [line]:${line}
                                echo [DBG]: file absoulte path:$2
                                if [ ${line} == ${2##*/} ]; then
                                        # TODO: if matched, clear the two lines
                                        # echo [DBG]: file found
                                        read -r line
                                        # cp ./${2} ./${2}.bk
                                        # echo [DBG]: parameter 2 is $2
                                        mv ${2} ${2%/*}/${line}
                                        return 11
                                else
                                        echo [DBG]: file not found
                                        continue
                                fi
                        done
                        return 1        # file not found
                else # directory
                        echo [DBG]: directory restore
                        # get absolute of files
                        if [ a${2%%/*} != a ]; then
                                CUR_DIR_PATH=$PWD/${2} # relatvie path
                        else
                                CUR_DIR_PATH=${2} # absolute path
                        fi
                        # check if directory contains / in the end
                        if [ a${2##*/} != a ]; then
                                CUR_DIR_PATH=$CUR_DIR_PATH/ # add / to the end of directory
                                # echo [DBG]: $CUR_DIR_PATH
                        fi
                        cd $CUR_DIR_PATH && CUR_DIR_FILE=`ls`
                        for val in $CUR_DIR_FILE
                        do
                                echo [DBG]: file to be restored: $CUR_DIR_PATH$val
                                # cd /home/gemini/workspace/cs/bash/abs_guide/tmp && $0 $1 $CUR_DIR_PATH$val # recursive
                                $0 $1 $CUR_DIR_PATH$val # recursive
                                if [ $? == 0 ]; then
                                        echo [DBG]: [$val] resume OK
                                        echo [DBG]: return value: [$?]
                                        echo "-------------------------------------"
                                else
                                        echo [DBG]: [$val] resume NG
                                        echo [DBG]: return value: [$?]
                                        echo "-------------------------------------"
                                fi
                        done
                fi
        else
                # excel: 2 columns[original->new]
                echo "Error: file or directory not exist."
        fi
}


function file_rename()
{
        errno=0
        echo [DBG]: rename files
        # echo $PWD/$1 >> .rename.sufix.bin
        # get absolute path from parameter
        # if [ != /] # TODO: absolute get
        tmp_file=`date +%Y%m%d%H%M%S`.bin
        original_file=$1
        echo [DBG]: parameter passed by directory: [$1]
        echo [DBG]: file test:  ${1%/*}
        if [ -d ${1%/*} ]; then
                echo [DBG]: absolute path
                abs_path=${1%/*}/   # if in other directory
                original_file_name_only=${1##*/}
                echo [DBG]: [abs_path] $abs_path
                echo [DBG]: [original_file] $original_file
        else
                echo [DBG]: file name only
                abs_path=./         # file in current directory(where shell executes)
                original_file_name_only=$1
        fi
        echo [DBG]: now pwd:$PWD
        echo [DBG]: now absolute path: $abs_path
        if false; then          # comment
        # if [ -d ${1%/*} ]; then # if in other directory
                echo [DBG]: absolute path
                # cp ${1} ${1}.bk
                mv ${1} ${1%/*}/${tmp_file}
                echo $tmp >> ${1%/*}/.rename.sufix.bin # new file
                echo ${1##*/} >> ${1%/*}/.rename.sufix.bin   # original file
                sleep 1
        # else # file name only
        fi
                # Modify: file and directory changes to same handle
                # echo [DBG]: file name only
                # cp $original_file $abs_path$original_file.bk
                mv $original_file $abs_path${tmp_file}
                if [ $errno != 0 ]; then
                        echo "Error: mv error"
                        return 2222
                fi
                echo $tmp_file >> $abs_path.rename.sufix.bin # new file
                echo $original_file_name_only >> $abs_path.rename.sufix.bin   # original file
                sleep 1                                             # modify
                return 0
        #fi
}

function main()
{
        if [ ! -z $1 ]; then
                if [ -d $1 ]; then
                        # rename: files in directory(recursive)
                        dir_file_rename $1
                else
                        if [ $1 == -r ]; then
                                # resume: resume files
                                resume_file $1 $2
                        else
                                # rename: files
                                file_rename $1
                        fi
                fi
        else                            # help msg
cat <<EOF
USAGE: $0 OPTION [ARGUMENT]
OPTION can be the following:
  -r restore file specified by ARGUMENT
ARGUMENT can either be file or directory
EOF
        fi
}

main $1 $2 $3
# script end
