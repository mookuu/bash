#!/bin/bash -x

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
        echo "`basename $0` file\|directory"
        exit 0
fi

# main function
mod_main() {
	local f_name
	local cur_dir

	# regular files
	if [ -f $1 ] && [ "${1##*.}" = "$F_SHELL" ]; then
		echo "Regular file: `pwd`/$1"
		sudo chmod 755 $1
        #################################
        # elif [ -d $1 ]; then          #
        #         # Read directory      #
        #         echo "Directory: $1"  #
        #         cd $1 && cur_dir=`ls` #
        #         for val in $cur_dir   #
        #         do                    #
        #                 mod_main $val #
        #         done                  #
        #################################
	else
		# TODO: default to regualr files, pipe, sockets...
		echo "Other file: $1"
		sudo chmod 644 $1
	fi
}

mod_main $1
# return value chk
[ "$?" -ne "$RTN_VALUE" ] && exit $ERR_UNKNOWN

echo "Mod change succeed"
echo

exit 0
