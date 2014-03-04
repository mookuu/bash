#!/bin/bash

# This shell renames sufix of files in the specified folder
# USAGE: rename_sufix.sh path

if [ ! -z $1 ]; then
        if [ -d $1 ]; then
                # directory
                echo [DBG]: if directory
                if [ a${1##*/} != a ]; then
                        CUR_DIR_PATH=${1}/ # add / to the end of directory
                else
                        CUR_DIR_PATH=${1} # add / to the end of directory
                fi
                # echo [DBG]: [\$1]: $1
                cd $1 && CUR_DIR=`ls`
                for val in $CUR_DIR
                do
                        echo [DBG]: val: $val
                        if [ -e $val ]; then
                                echo [DBG]: come here 1
                                cd /home/gemini/workspace/cs/bash/abs_guide/tmp && $0 $CUR_DIR_PATH$val # recursive
                                #echo [DBG]: [\$\0]$0
                                #echo [DBG]: [path] $CUR_DIR_PATH$val
                                echo [DBG]: come here 2
                        else
                                echo [DBG]: come here 4, not a file
                        fi
                done
        else
                if [ $1 == -r ]; then # if contains OPTION, restore from specified file
                        if [ ! -z $2 ]; then
                            if [ ! -d $2 ]; then
                                cat ${2%/*}/.rename.sufix.bin | while read -r line
                                do
                                        echo [DBG]: [line]:${line}
                                        echo [DBG]: [\$\2]:$2
                                        if [ ${line} == ${2##*/} ]; then
                                                # TODO: if matched, clear the two lines
                                                # echo [DBG]: file found
                                                read -r line
                                                # cp ./${2} ./${2}.bk
                                                # echo [DBG]: parameter 2 is $2
                                                mv ./${2} ./${2%/*}/${line}
                                                break
                                        else
                                                echo [DBG]: file not found
                                                continue
                                        fi
                                done
                            else # directory
                                    echo [DBG]: directory restore
                                    cd $2 && CUR_DIR=`ls`
                                    if [ a${1##*/} != a ]; then
                                            CUR_DIR_PATH=${2}/ # add / to the end of directory
                                    else
                                            CUR_DIR_PATH=${2} # add / to the end of directory
                                    fi
                                    for val in $CUR_DIR
                                    do
                                            echo [DBG]: file to be restored: $CUR_DIR_PATH$val
                                            cd /home/gemini/workspace/cs/bash/abs_guide/tmp && $0 $1 $CUR_DIR_PATH$val # recursive
                                    done
                            fi
                        else
                                # excel: 2 columns[original->new]
                                echo "Error: file or directory not exist."
                        fi
                else            # regular files
                        echo [DBG]: comes here 3
                        # echo $PWD/$1 >> .rename.sufix.bin
                        # get absolute path from parameter
                        # if [ != /] # TODO: absolute get
                        abs_path=${PWD}
                        tmp=`date +%Y%m%d%H%M%S`.bin
                        echo [DBG]: now pwd:$PWD
                        echo [DBG]: now para1: $1
                        if [ -d ${1%/*} ]; then # absolute path
                                echo [DBG]: absolute path
                                # cp ${1} ${1}.bk
                                mv ${1} ${1%/*}/${tmp}
                                echo $tmp >> ${1%/*}/.rename.sufix.bin # new file
                                echo ${1##*/} >> ${1%/*}/.rename.sufix.bin   # original file
                                sleep 1
                        else # file name only
                                echo [DBG]: file name only
                                # cp ./${1} ./${1}.bk
                                mv ./${1} ./${tmp}
                                echo $tmp >> .rename.sufix.bin # new file
                                echo $1 >> .rename.sufix.bin   # original file
                        fi
                fi
        fi
else
cat <<EOF
USAGE: $0 OPTION [ARGUMENT]
OPTION can be the following:
  -r restore file specified by ARGUMENT
ARGUMENT can either be file or directory
EOF
fi
