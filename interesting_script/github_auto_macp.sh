#!/bin/bash

#  Automatically add, commit, push files to github
#  Update
#       Parameter check added @2014-04-15 by H

RET=0
D_COM_TRUE=1
D_COM_FALSE=0
E_PARA_ERR=86
E_UNKNOWN_FT=87
E_ADD_ERR=88
E_COMMIT_ERR=89
E_PUSH_ERR=90

GIT_ADD_FILE="-a"
GIT_ADD_FILE1="--add"
GIT_REMOVE_FILE="-r"
GIT_REMOVE_FILE1="--remove"
GIT_COMMENT_FLAG="-m"
GIT_COMMENT_CUSTOMIZE=$D_COM_FALSE
PATH_LOG=/home/kohata/work/cs/log/trace.log

#  TODO: deal confilict(merge)

#  Usage
usage()
{
        echo "USAGE"
	echo "       `basename $0` [options] file|directory"
        echo "OPTIONS"
	echo "       -a, --add"
	echo "          Add file contents to the index."
	echo "       -r, --remove"
	echo "          Remove files from the working tree and from the index."
	echo "       -m"
	echo "          Add comment to current commit."
        # TODO: gg -a file(s)|directory -r file(s)|directory # unecessary
#	exit $E_PARA_ERR
}

#  Option chk
opt_chk()
{
    :
}

#  Parameter chk
para_chk()
{
        # Null parameter chk
	if [ -z "$1" ]; then
                echo "[DBG]: Null parameter!" && echo
		usage		# print usage
	fi

        #
	# TODO: -m comment
        while [ -n "$1" ]
        do
                case "$1" in
                    $GIT_ADD_FILE|$GIT_ADD_FILE1)
                        echo "[DBG]: Add mode"
                        # gg -a file|directory
                        # gg -a -m "customize-comment" file|dir
                        # TODO: gg -a files -r files
                        # gg -a -m -r
                        break
                        ;;
                    $GIT_REMOVE_FILE|$GIT_REMOVE_FILE1)
                        echo "[DBG]: Remove mode"
                        break
                        ;;
                    $GIT_COMMENT_FLAG)
                        echo "[DBG]: Customize comment mode."
                        break
                        ;;
                    # TODO: default add mode
                    *)
                        if [ ${1:0:1} = - ]; then
                                echo "[DBG]: '$1' unknown mode." && echo
                                usage
                        else    # TODO: file check?
                                echo "[DBG]: default mode(add mode)."
                        fi
                        break
                        ;;
                esac
        done
}

para_chk $1 $2 $3 $4 $5 $6
echo "before exit"
exit

#  Parameter chk
para_chk $1 $2 $3 $4 $5 $6

#  Option chk
opt_chk


#  Customize comment
if [ $GIT_COMMENT_FLAG = $1 ] || []; then
	str=$2
	echo "[DBG]: [L38] $2"
	# If parameters contains '-m' but without customize comment
	# TODO:
	#     ag -m "test.sh"
	#     specified customize comment but notify not
	#     should determine " in $2
	if [ "x${str##* }" = "x$str" ]; then	# If comment doesn't contains blank
		if [ -f $2 ] || [ -d $2 ]; then
			echo "[DBG]: Specify '-m' but without customize comment"
			usage
		fi
	fi
	COMMENT_CUSTOMIZE=$2
	GIT_COMMENT_CUSTOMIZE=$D_COM_TRUE
	shift 2
	echo "[DBG]: First file[$1]"
	#  Parameter chk
	if [ -z $1 ]; then
		usage
	fi
	echo "[DBG]: Shift the parameter"
fi

#  TODO: files add directory
#  File(s)
if [ -f $1 ]; then
	while [ ! -z $1 ]
	do
		echo "[DBG]: File(s)"
		git add $1
		shift 1
	done
elif [ -d $1 ]; then	# Directory
	# M1
	echo "[DBG]: Directory"
	git add $1
	# M2
if false; then
	if [ x{$1##/} = x ]; then
		git add $1*
	else
		git add $1/*
	fi
fi
else	# Unknown file type
	echo "Unknown file type"
	exit $E_UNKNOWN_FT
fi
[ $? -ne $RET ] && echo "Error happend when add file(s)" && exit $E_ADD_ERR


#  Commit files to History
if [ $D_COM_TRUE -eq $GIT_COMMENT_CUSTOMIZE ]; then
	echo "[DBG]: Customize comment"
	git commit -m "$COMMENT_CUSTOMIZE `date +%Y-%m-%d\ %T`"
else
	echo "[DBG]: Defaule comment"
	git commit -m "Kohata@nj `date +%Y-%m-%d\ %T`"
fi
[ $? -ne $RET ] && echo "Error happend when commit" && exit $E_COMMIT_ERR

#  Push files to github
git push origin master
[ $? -ne $RET ] && echo "Error happend when push" && exit $E_PUSH_ERR

exit
