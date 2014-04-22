#!/bin/bash

#
# Change file's privilege automatically
#

RTN_VALUE=0	# return OK
ERR_UNKNOWN=85	# error number
F_SHELL=sh

# Parameter chk
# [ -z $1 ] && echo "null parameter" && exit 0
if [ $# -lt 1 ]; then
        echo "Usage:"
        echo "   `basename $0` file|directory"
        exit 0
fi

# main function
mod_main() {
	local f_name
	local cur_dir

	# regular files
        # echo "[DBG]: Path-> `pwd`"
	if [ -f $1 ] && [ "${1##*.}" = "$F_SHELL" ]; then
		echo "Regular file: `pwd`/$1"
		# sudo chmod 755 $1	# in case of overstep authority
		chmod 755 $1

        elif [ -d $1 ]; then
		# Read directory
		echo "Directory: `pwd`/$1"
		chmod 755 $1
		cd $1 && cur_dir=`ls`
		for val in $cur_dir
		do
			mod_main $val
	        done
                cd ..           # change dir
	else
		# TODO: default to regualr files, pipe, sockets...
		echo "Other file: `pwd`/$1"
		sudo chmod 644 $1	# in case of overstep authority
		chmod 644 $1
	fi
}

mod_main $1
# return value chk
[ "$?" -ne "$RTN_VALUE" ] && echo "[ERR]: Mod change failed" && exit $ERR_UNKNOWN

echo "Mod change succeed"
echo

exit 0
