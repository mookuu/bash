#!/bin/bash

#  Automatically add, commit, push files to github
#  Update
#       Parameter check added @2014-04-15 by H

#  TODO: parameter check and git add --> seperate???

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
GIT_ADD_FLAG=$D_COM_FALSE
GIT_REMOVE_FILE="-r"
GIT_REMOVE_FILE1="--remove"
GIT_COMMENT_FLAG="-m"
GIT_COMMENT_CUSTOMIZE=$D_COM_FALSE
PATH_LOG=/home/kohata/work/cs/log/trace.log

# Commit files and push to github
git_push()
{
        #  Commit files
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
}

#  Usage
usage()
{
        echo "USAGE"
	echo "       `basename $0` [options] files|directory"
        echo "OPTIONS"
	echo "       -a, --add"
	echo "          Add file contents to the index."
	echo "       -r, --remove"
	echo "          Remove files from the working tree and from the index."
	echo "       -m"
	echo "          Add comment to current commit."
        # TODO: gg -a file(s)|directory -r file(s)|directory # unecessary
	exit $E_PARA_ERR
}


#  Add mode
add_mode()
{
        #  files==file|directory
        #  Case:
        #      M1: gg files
        #      M2: gg -a files
        #      M3: gg -a -m "customize-comment" files
        #      M4: gg -a files -m "customize-comment"
        #      M5: TODO: gg -am? or gg -a -m
        #      M6: gg -a files -r files --> not recommand
        #      M7: gg -a files -m "customize-comment" -r files
        #      M8: gg -a files -r files -m "customize-comment"

        echo "[DBG]: In add mode"
        if [ "$1" != "-a" ] && [ "$1" != "-m" ] && [ "$1" != "-r" ]; then
		# default mode(without option)
		while [ -n "$1" ]
		do
                        # M1: gg files
                        # M2: gg -a files
                        # M3: gg -a -m "customize-comment" files
                        # M4: gg -a files -m "customize-comment"
                        # M5: TODO: gg -am? or gg -a -m
                        # M6: gg -a files -r files --> not recommand
                        # M7: gg -a files -m "customize-comment" -r files
                        # M8: gg -a files -r files -m "customize-comment"
			if [ -f "$1" ]; then	# file
                                echo "[DBG]: File '$1' added."
				git add $1
			elif [ -d "$1" ]; then	# Directory
				# M1
				if [ x${1##*/} = x ]; then
                                        tet=${1%%/}
                                        echo "[DBG]: Directory '${tet##/}' added."
				else
                                        echo "[DBG]: Directory '$1' added."
				fi
				git add $1
				# M2
				if false; then
					if [ x${1##*/} = x ]; then
						git add $1*
					else
						git add $1/*
					fi
				fi
                        # M4: git -a files -m "customize-commet"
                        elif [ "$1" == "-m" ]; then
                                add_mode "$@"
                                break
                        elif [ "$1" == "-r" ]; then
                                add_mode "$@"
                                break
			else	# Unknown file type
				echo "[ERR]: Unknown file type[$1]"
				exit $E_UNKNOWN_FT
			fi
			shift 1
		done
        elif [ "$1" = "-m" ]; then
                # M3: gg -a -m "customize-comment" files
                # M4: gg -a files -m "customize-comment"
                # M7: gg -a files -m "customize-comment" -r files
                # M8: gg -a files -r files -m "customize-comment"
                # shift -m
                echo "[DBG]: '-m' parameter deal."
                shift 1
                if [ -z "$1" ]; then
                        echo "[ERR]: Specify '-m' but without customize comment" && echo
		        usage		# print usage
                fi
	        str=$1
	        if [ "x${str##* }" = "x$str" ]; then	# If comment doesn't contains blank
		        if [ -f $1 ] && [ -d $1 ]; then
			        echo "[ERR]: Specify '-m' but without customize comment" && echo
			        usage
		        fi
	        fi
	        COMMENT_CUSTOMIZE=$1
                echo "[DBG]: Customize-comment: $COMMENT_CUSTOMIZE"
                # shfit customize-comment
                shift 1
                # M7: gg -a files -m "customize-comment" -r files
                if [ -n "$1" ]; then
                        add_mode "$@"
                fi
        elif [ "$1" = "-r" ]; then
                # M6: gg -a files -r files
                # M7: gg -a files -m "customize-comment" -r files
                # M8: gg -a files -r files -m "customize-comment"
                # shift -r
                echo "[DBG]: '-r' parameter deal."
                shift 1
                # Null parameter
                if [ -z "$1" ]; then
                        echo "[ERR]: Specify '-r' but without files to remove."
		        usage		# print usage
                fi
                # Not file
                if [ ! -f "$1" ] && [ ! -d "$1" ]; then
                        echo "[ERR]: Specify '-r' but without files to remove."
		        usage		# print usage
                fi
                while [ -n "$1" ]
                do
		        if [ -f "$1" ]; then    # file
		                git rm $1
                        elif [ -d "$1" ]; then  # directory
                                git rm -r $1
                        elif [ "$1" == "-m" ]; then
                                add_mode "$@"
                                break
                        else
				echo "[ERR]: Unknown file type[$1]"
				exit $E_UNKNOWN_FT
                        fi
                        shift 1
                done
	elif [ "$1" = "-a" ]; then
                # M2: gg -a files
                # M3: gg -a -m "customize-comment" files
                # M4: gg -a files -m "customize-comment"
                # M6: gg -a files -r files --> not recommand
                # M7: gg -a files -m "customize-comment" -r files
                # M8: gg -a files -r files -m "customize-comment"
                # shift -a
                echo "[DBG]: '-a' parameter deal."
                # M3: Special deal
                if [ "$2" = "-m" ]; then
                        if [ ! -f "$4" ] && [ ! -d "$4" ]; then
                                echo "[ERR]: Specify '-a' but without files." && echo
                                usage		# print usage
                        fi
                fi
                shift 1
                add_mode "$@"
	fi
}

#  Remove mode
remove_mode()
{
        echo "[DBG]: In remove mode"
}

#  Comment mode
comment_mode()
{
        echo "[DBG]: In comment mode"
}

#  Call reference mode
mode_dispatch()
{
        # TODO: -m comment
        for val in "$@"
        do
                echo "[DBG]: Parameter from CLI: $val"
                case "$val" in
                        $GIT_ADD_FILE|$GIT_ADD_FILE1)
                                echo "[DBG]: Add mode"
                                add_mode "$@"
                                break
                                ;;
                        $GIT_REMOVE_FILE|$GIT_REMOVE_FILE1)
                                echo "[DBG]: Remove mode"
                                remove_mode "$@"
                                break
                                ;;
                        $GIT_COMMENT_FLAG)
                                echo "[DBG]: Customize comment mode."
                                 comment_mode "$@"
                                break
                                ;;
                        # TODO: default add mode
                        *)
                                if [ ${1:0:1} = - ]; then
                                        echo "[DBG]: '$1' unknown mode." && echo
                                        usage
                                else    # TODO: file check?
                                        echo "[DBG]: Default mode(add mode)."
                                        add_mode "$@"
                                fi
                                break
                                ;;
                esac
        done
}


#  Parameter chk
para_chk()
{
        # Null parameter chk
	if [ -z "$1" ]; then
                echo "[DBG]: Null parameter!" && echo
		usage		# print usage
	fi

        case $1 in
                $GIT_COMMENT_FLAG|\
	        $GIT_ADD_FILE|$GIT_ADD_FILE1|\
                $GIT_REMOVE_FILE|$GIT_REMOVE_FILE1)
                       if [ $2 -lt 2 ]; then
                               echo "[DBG]: Parameter error." && echo
		               usage		# print usage
                               exit $E_PARA_ERR
                       fi
                       echo "[DBG]: Parameter check OK."
		       ;;
                # Default mode
                *)
         	       if [ ${1:0:1} = - ]; then
         		       echo "[DBG]: '$1' unknown mode." && echo
         		       usage
         	       else    # TODO: file check?
         		       echo "[DBG]: Parameter check OK."
         	       fi
         	       ;;
        esac
}

#  Main function
main()
{
        # Parameter check
        para_chk "$1" "$#"

        # Add or Remove files to stage(index)
        mode_dispatch "$@"

        # TODO: merge, pull

        # Commit files in stage(index) to github
        git_push
}

main "$@"     # pass all CLI parameters
echo "before exit"
exit


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


exit
