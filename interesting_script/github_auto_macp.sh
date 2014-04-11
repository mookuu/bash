#!/bin/bash

#  Automatically add, commit, push files to github
#

RET=0
D_COM_TRUE=1
D_COM_FALSE=0
E_PARA_ERR=86
E_UNKNOWN_FT=87
E_ADD_ERR=88
E_COMMIT_ERR=89
E_PUSH_ERR=90

GIT_COMMENT="-m"
GIT_COMMENT_CUSTOMIZE=$D_COM_FALSE
PATH_LOG=/home/kohata/work/cs/log/trace.log

#  TODO: deal confilict(merge)

#  Usage
usage()
{
	echo "Usage:"
	echo "	`basename $0` [-m] comment file(s)|directory"
	exit $E_PARA_ERR
}


#  Add files to stage
#  Parameter chk
if [ -z $1 ]; then
	usage
fi
#  Customize comment
if [ $GIT_COMMENT = $1 ]; then
	if [ -f $2 ] || [ -d $2 ]; then
		usage
	else
		GIT_COMMENT_CUSTOMIZE=$D_COM_TRUE
		shift 2
		#  Parameter chk
		if [ -z $1 ]; then
			usage
		fi
		echo "[DBG]: Shift the parameter"
	fi
fi
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
	git commit -m "$2 `date +%Y-%m-%d\ %T`"
else
	echo "[DBG]: Defaule comment"
	git commit -m "Kohata@nj `date +%Y-%m-%d\ %T`"
fi
[ $? -ne $RET ] && echo "Error happend when commit" && exit $E_COMMIT_ERR

#  Push files to github
git push origin master
[ $? -ne $RET ] && echo "Error happend when push" && exit $E_PUSH_ERR
