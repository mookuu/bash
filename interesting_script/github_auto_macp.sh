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
E_PULL_ERR=91
E_PARA_LACK=92

GIT_PULL="-p"
GIT_PULL_EX="--pull"
GIT_ADD="-a"
GIT_ADD_EX="--add"
GIT_ADD_FLAG=$D_COM_FALSE
GIT_REMOVE="-r"
GIT_REMOVE_EX="--remove"
GIT_REMOVE_FLAG=$D_COM_FALSE
GIT_COMMENT="-m"
GIT_COMMENT_EX="--comment"
GIT_COMMENT_FLAG=$D_COM_FALSE
GIT_ADD_COMMENT_FLAG=$D_COM_FALSE       # M5:  gg -a -m "customize-comment" files
GIT_ADD_RM_COMMENT_FLAG=$D_COM_FALSE    # M7:  gg -a files -r -m "customize-comment" files
GIT_RM_COMMENT_FLAG=$D_COM_FALSE        # M13:   gg -r -m "customize-comment" files
GIT_RM_ADD_COMMENT_FLAG=$D_COM_FALSE    # M15: gg -r files -a -m "customize-comment" files
PATH_LOG=/home/kohata/work/cs/log/trace.log

#  Usage
usage()
{
        echo "USAGE"
	echo "       `basename $0` [options] files|directory"
        echo "OPTIONS"
	echo "       -a, --add"
	echo "          Add file contents to the index."
	echo "       -m, --comment"
	echo "          Add comment to current commit."
        echo "       -p, --pull"
        echo "          Pull source from github to local working directory."
	echo "       -r, --remove"
	echo "          Remove files from the working tree and the index."
        # TODO: gg -a file(s)|directory -r file(s)|directory # unecessary
	exit $E_PARA_ERR
}

# Commit files and push to github
git_push()
{
        #  Commit files
        if [ $D_COM_TRUE -eq $GIT_COMMENT_FLAG ]; then
                echo "`date +%Y/%m/%d-%T`[L58]: `basename $0` Use customize comment."
                git commit -m "$COMMENT_CUSTOMIZE `date +%Y-%m-%d\ %T`"
        else
                echo "`date +%Y/%m/%d-%T`[L62]: `basename $0` Use default comment."
                git commit -m "Kohata@nj `date +%Y-%m-%d\ %T`"
        fi
        [ $? -ne $RET ] && \
            echo "`date +%Y/%m/%d-%T`[L66]: `basename $0` [Error] error happend when commit[errno: $E_COMMIT_ERR]." && \
            exit $E_COMMIT_ERR

        #  Push files to github
        git push origin master
        [ $? -ne $RET ] && \
            echo "`date +%Y/%m/%d-%T`[L72]: `basename $0` [Error] error happend when push[errno: $E_PUSH_ERR]." && \
            exit $E_PUSH_ERR
}

#  Pull mode
#  TODO: Conflict and merge
mode_pull()
{
        echo "`date +%Y/%m/%d-%T`[L80]: `basename $0` [Debug] inside pull mode."
        git pull origin master
        [ $? -ne $RET ] && \
            echo "`date +%Y/%m/%d-%T`[L83]: `basename $0` [Error] error happend when pull[errno: $E_PULL_ERR]." && \
            exit $E_PULL_ERR
        exit
}

#  Comment mode
mode_comment()
{
       echo "`date +%Y/%m/%d-%T`[L91]: `basename $0` [Debug] inside customize-comment mode."
       if [ -z "$1" ]; then
               echo "`date +%Y/%m/%d-%T`[L91]: `basename $0` [Error] specify '-m' but without customize comment." && echo
	       usage		# print usage
       fi
       str=$1
       if [ "x${str##* }" = "x$str" ]; then	# If comment doesn't contains blank
	       if [ -f "$1" ] && [ -d "$1" ]; then
                       echo "`date +%Y/%m/%d-%T`[L98]: `basename $0` [Error] specify '-m' but without customize comment." && echo
		       usage
	       fi
       fi
       COMMENT_CUSTOMIZE=$1
       echo "`date +%Y/%m/%d-%T`[L104]: `basename $0` [Debug] customize-comment: $COMMENT_CUSTOMIZE."
       # shfit customize-comment
       shift 1
       # M5: gg -a -m "customize-comment" files
       # M7: gg -a files -m "customize-comment" -r files
       if [ -n "$1" ]; then
               echo "`date +%Y/%m/%d-%T`[L110]: `basename $0` [Debug] parameter after comment: $1."
               mode_dispatch_ex "$@"
       fi

}

#  Remove mode
mode_remove()
{
        echo "[DBG]: In remove mode"
        echo "`date +%Y/%m/%d-%T`[L119]: `basename $0` [Debug] inside remove mode."
	# Null parameter
	if [ -z "$1" ]; then
                echo "`date +%Y/%m/%d-%T`[L123]: `basename $0` [Error] specify '-r' but without files to remove."
		usage		# print usage
	fi
	# Not file
        # M7:  gg -a files -r -m "customize-comment" files
        if [ ! -f "$1" ] && [ ! -d "$1" ] && \
            [ $GIT_ADD_RM_COMMENT_FLAG -ne $D_COM_TRUE ] && \
            [ $GIT_RM_COMMENT_FLAG -ne $D_COM_TRUE ]; then
                echo "`date +%Y/%m/%d-%T`[L131]: `basename $0` [Error] specify '-r' but without files to remove[errno: ]."
	        usage		# print usage
        fi

        # Remainder
        while [ -n "$1" ]
        do
                if [ -f "$1" ]; then	# file
                        git rm $1
                elif [ -d "$1" ]; then  # directory
                        git rm -r $1
                elif [ "$1" = "-a" ] || \
                     [ "$1" = "-m" ]; then
                        mode_dispatch_ex "$@"
                        break
                else
	                echo "`date +%Y/%m/%d-%T`[L147]: `basename $0` [Error] unknown file type[$1][errno: $E_UNKNOWN_FT]."
                 	exit $E_UNKNOWN_FT
                fi
                shift 1
        done
}

#  Add mode
mode_add()
{
        echo "[DBG]: In add mode"
        while [ -n "$1" ]
        do
	        if [ -f "$1" ]; then	# file
	                git add $1
	                [ $? -ne $RET ] && echo "Error happend when add file(s)" && exit $E_ADD_ERR
	                echo "[DBG]: File '$1' added."
	        elif [ -d "$1" ]; then	# Directory
	                # M1
	                git add $1
	                       [ $? -ne $RET ] && echo "Error happend when add file(s)" && exit $E_ADD_ERR
	                if [ x${1##*/} = x ]; then
	                        tet=${1%%/}
	                	echo "[DBG]: Directory '${tet##/}' added."
	                else
	                        echo "[DBG]: Directory '$1' added."
	                fi
	                # M2
	                if false; then
	                	if [ x${1##*/} = x ]; then
	                		git add $1*
	                	else
	                		git add $1/*
	                	fi
	                fi
                # M4: git -a files -m "customize-commet"
                # TODO: Default mode + '-a'
                elif [ "$1" = "-a" ]; then
                        add_mode "$@"
                        break
	        elif [ "$1" = "-m" ] || \
                     [ "$1" = "-r" ]; then
	                mode_dispatch_ex "$@"
	                break
	        else	# Unknown file type
	                echo "[ERR]: Unknown file type[$1]"
	                exit $E_UNKNOWN_FT
	        fi
	        shift 1
        done
}


#  Add mode
mode_dispatch_ex()
{
        #  files=file|directory
        #  Case:
        #      ----gg -a------------------------------------------------
        #      M1:  gg files                                       -->OK
        #      M2:  gg -a files                                    -->OK
        #      M3:  gg -a files -r files                           -->OK
        #      M4:  gg -a files -m "customize-comment"             -->OK
        #      M5:  gg -a -m "customize-comment" files             -->OK
        #      M6:  gg -a files -r files -m "customize-comment"    -->OK
        #      M7:  gg -a files -r -m "customize-comment" files    -->OK
        #      M8:  gg -a files -m "customize-comment" -r files    -->OK
        #      M9:  TODO: gg -am? or gg -a -m                      -->NG
        #      ----gg -r------------------------------------------------
        #      M10: gg -r files                                    -->OK
        #      M11: gg -r files -a files                           -->OK
        #      M12: gg -r files -m "customize-comment"             -->OK
        #      M13: gg -r -m "customize-comment" files             -->OK
        #      M14: gg -r files -a files -m "customize-comment"    -->OK
        #      M15: gg -r files -a -m "customize-comment" files    -->OK
        #      M16: gg -r files -m "customize-comment" -a files    -->OK
        #      ----gg -m------------------------------------------------
        #      M17: gg -m "customize-comment"(No such case)        -->NG
        #      M18: gg -m "customize-comment" -a files             -->OK
        #      M19: gg -m "customize-comment" -r files             -->OK
        #      M20: gg -m "customize-comment" -a files -r files    -->OK
        #      M21: gg -m "customize-comment" -r files -a files    -->OK



        echo "[DBG]: In Dispatch-extense mode."
        if [ "$1" != "-a" ] && [ "$1" != "-m" ] && [ "$1" != "-r" ]; then
	        # default mode(without option)--can't gurantee default mode!!!

                # M5:  gg -a -m "customize-comment" files
                if [ $GIT_ADD_COMMENT_FLAG -eq $D_COM_TRUE ] || \
                    [ $GIT_RM_ADD_COMMENT_FLAG -eq $D_COM_TRUE ]; then
                        mode_add "$@"
                elif [ $GIT_ADD_RM_COMMENT_FLAG -eq $D_COM_TRUE ] || \
                     [ $GIT_RM_COMMENT_FLAG -eq $D_COM_TRUE ]; then
                        mode_remove "$@"
                else
                        mode_add "$@"
                fi
        elif [ "$1" = "-m" ]; then
                echo "[DBG]: '-m' parameter deal."
                # shift '-m' parameter
                shift 1
                GIT_COMMENT_FLAG=$D_COM_TRUE
                mode_comment "$@"
        elif [ "$1" = "-r" ]; then
                echo "[DBG]: '-r' parameter deal."

                # M13: gg -r -m "customize-comment" file
                if [ "$2" = "-m" ]; then
                        if [ ! -f "$4" ] && [ ! -d "$4" ]; then
                                echo "[ERR]: Specify '-a' but without files." && echo
                                usage		# print usage
                        fi
                        GIT_RM_COMMENT_FLAG=$D_COM_TRUE
                fi
                # M15: gg -r files -a -m "customize-comment" files
                if [ "$3" = "-a"] && [ "$4" = "-m" ]; then
                        if [ ! -f "$6" ] && [ ! -d "$6" ]; then
                                echo "[ERR]: Specify '-a' but without files." && echo
                                usage		# print usage
                        fi
                        GIT_RM_ADD_COMMENT_FLAG=$D_COM_TRUE
                fi
                # shift '-r' parameter
                shift 1
                GIT_REMOVE_FLAG=$D_COM_TRUE
                mode_remove "$@"
	elif [ "$1" = "-a" ]; then
                echo "[DBG]: '-a' parameter deal."

                # Special deal
                # M5: gg -a -m "customize-comment" files
                if [ "$2" = "-m" ]; then
                        if [ ! -f "$4" ] && [ ! -d "$4" ]; then
                                echo "[ERR]: Specify '-a' but without files." && echo
                                usage		# print usage
                        fi
                        GIT_ADD_COMMENT_FLAG=$D_COM_TRUE
                else    # gg "deal" -a files
	                if [ -z "$2" ]; then
                                echo "[ERR]: Specify '-a' but without files." && echo
                                usage		# print usage
                        fi
                        if [ ! -f "$2" ] && [ ! -d "$2" ]; then
                                echo "[ERR]: Specify '-a' but without files." && echo
                                usage		# print usage
                        fi
                fi
                # M7: gg -a files -r -m "customize-comment" files
                if [ "$3" = "-r"] && [ "$4" = "-m" ]; then
                        if [ ! -f "$6" ] && [ ! -d "$6" ]; then
                                echo "[ERR]: Specify '-a' but without files." && echo
                                usage		# print usage
                        fi
                        GIT_ADD_RM_COMMENT_FLAG=$D_COM_TRUE
                fi

                # shift '-a' parameter
                shift 1
                GIT_ADD_FLAG=$D_COM_TRUE
                mode_add "$@"
	fi
}


#  Call reference mode
mode_dispatch()
{
        # TODO: -m comment
        for val in "$@"
        do
                echo "[DBG]: Dispatch mode."
                case "$val" in
                        $GIT_ADD|$GIT_ADD_EX|\
                        $GIT_REMOVE|$GIT_REMOVE_EX)
                                echo "`date +%Y/%m/%d-%T`[L316]: `basename $0` Dispatch-extense mode." && echo
                                mode_dispatch_ex "$@"
                                break
                                ;;
                        $GIT_COMMENT|$GIT_COMMENT_EX)
                                if [ "$#" -le 2 ]; then
                                        echo "`date +%Y/%m/%d-%T`[L321]: `basename $0` Parameter error[errno: $E_PARA_LACK]." && echo
                                else
                                        mode_dispatch_ex "$@"
                                fi
                                break
                                ;;
                        $GIT_PULL|$GIT_PULL_EX)
                                echo "[DBG]: Pull mode."
                                mode_pull
                                break
                                ;;
                        # TODO: default add mode
                        *)
                                if [ ${1:0:1} = "-" ]; then
                                        echo "[DBG]: '$1' unknown mode." && echo
                                        usage
                                else    # TODO: file check?
                                        echo "[DBG]: Default mode(add mode)."
                                        mode_add "$@"
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
                $GIT_ADD|$GIT_ADD_EX|\
                $GIT_REMOVE|$GIT_REMOVE_EX|\
                $GIT_COMMENT|$GIT_COMMENT_EX)
                        if [ "$2" -lt 2 ]; then
                                echo "[DBG]: Parameter error." && echo
		                usage		# print usage
                                exit $E_PARA_ERR
                        fi
                        echo "[DBG]: Parameter check OK."
		        ;;
                $GIT_PULL|$GIT_PULL_EX)
                        if [ "$2" -ne 1 ]; then
                                echo "[DBG]: Parameter error." && echo
		                usage		# print usage
                                exit $E_PARA_ERR
                        fi
                        echo "[DBG]: Parameter check OK."
                        ;;
                *)      # Default mode
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

