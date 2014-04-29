#!/bin/bash -x
#
# 1: add a schedule
# 	"crontab -e"
# 	0 6 * * * shell_path
# 2: restart the cron service
# 	sudo service cron restart
# 	or
# 	sudo /etc/init.d/cron resart
#
# github_src_v3 modified@20140421 by H
# update:
# 	source optimization
#

RET=0			#
PH2=ph2			#
PH3=ph3			#
RETRY_CNT=0		# initialization
RETRY_MAX=3		# retry count
TIMELIMIT=30m		# retry time
R_RESULT=1		# Flag: 0->OK 1->NG
R_SUCCEED=0		# success
R_FAILED=1		# fail
E_NETUNREACH=101	# errno
PH2_SRC_DOWNLOAD_RESULT=$R_FAILED
PH3_SRC_DOWNLOAD_RESULT=$R_FAILED
GIT_REMOTE_BRANCH=origin
LOG_POS=/home/ndvr/public/source/log/trace.log	# trace log
NEW_SRC_POS=/home/ndvr/public/source/		# newest ph2 and ph3 src position
GITHUB_ORIGIN=/home/ndvr/public/source/github_origin	# github temporary src directory

# Source directory-for enconde change
D_CNT=3
D_MAC[0]=/CAM/apl
D_MAC[1]=/DVR/apl
D_MAC[2]=/HUB/apl


# Encode change(utf8->euc-jp)
code_change()
{
        # Encode change
        for val in ${D_MAC[@]}
        do
                # Use absolutely path instead
                # NKF.sh already a shell, `` is not necessary
                # Modified @20140411 by H
		# ph2 src encode change
		if [ $PH2_SRC_DOWNLOAD_RESULT -eq $R_SUCCEED ]; then
        	        cd $NEW_SRC_POS`date +%Y-%m-%d`-ph2$val && ./NKF.sh euc-jp
	                if [ $? -ne $RET ]; then
				R_RESULT=$R_FAILED
				echo "Error: error occured when change encode in `date +%Y-%m-%d`$val." >>$LOG_POS
			else
				R_RESULT=$R_SUCCEED
			fi
		fi
		# ph3 src encode change
		if [ $PH3_SRC_DOWNLOAD_RESULT -eq $R_SUCCEED ]; then
        	        cd $NEW_SRC_POS`date +%Y-%m-%d`-ph3$val && ./NKF.sh euc-jp
	 	        if [ $? -ne $RET ]; then
				R_RESULT=$R_FAILED
				echo "Error: error occured when change encode in `date +%Y-%m-%d`$val." >>$LOG_POS
			else
				R_RESULT=$R_SUCCEED
			fi
		fi
        done
}

# Src get
src_get_func()
{
	# Clear all temporary files in case of __Merge__
	[ -d .git ] && rm -fr * && rm -fr .git
	# Initialization
	git init
	[ x$GIT_REMOTE_BRANCH = x`git remote` ] || \
		git remote add origin git@github.com:mcc-system/NDVR.git

	# ph2, ph3 or other branches
	if [ "$1" = "$PH2" ]; then
		git pull origin release_ph2
	elif [ "$1" = "$PH3" ]; then
		git pull origin develop
	else
		echo "Unknown branches." >>$LOG_POS
		return 0
	fi
	# rtn chk
	if [ "$?" -eq "$RET" ]; then
		chmod 755 -R *
		# mv cannot overwritten directory-man mv
		cp -fR * ../`date +%Y-%m-%d`-$1
		# mv -f * ../`date +%Y-%m-%d`-$1
		echo "Download succeed."
		R_RESULT=$R_SUCCEED
	else
		# echo "Error: cann't download $1 source." >>$LOG_POS
		R_RESULT=$R_FAILED

		# Retry: 3 times
		while [ $RETRY_CNT -lt $RETRY_MAX ] && [ $R_RESULT != $R_SUCCEED ]
		do
			((RETRY_CNT++))
			echo "$1 source download failed! Will retry in 30 minutes. [errno: $E_NETUNREACH]" >>$LOG_POS
			sleep $TIMELIMIT && echo "Retry[$RETRY_CNT]" >>$LOG_POS && src_get $1
			# endless loop???
		done
	fi
}


# Get source from github.com
src_get_main()
{
	# Ph2
	src_get_func ph2
	if [ $R_RESULT -ne $R_SUCCEED ]; then
	        echo "*****Error: cann't download ph2 source, please check the network!*****" >>$LOG_POS
	#       exit $NET_UNREACH
	else
		PH2_SRC_DOWNLOAD_RESULT=$R_SUCCEED
	fi
	RETRY_CNT=0
	# Ph3
	src_get_func ph3
	if [ $R_RESULT -ne $R_SUCCEED ]; then
	        echo "*****Error: cann't download ph3 source, please check the network!*****" >>$LOG_POS
	        exit $NET_UNREACH
	else
		PH3_SRC_DOWNLOAD_RESULT=$R_SUCCEED
	fi
	# TODO: other branch

	# Clear
	cd $GITHUB_ORIGIN/.. && rm -fr $GITHUB_ORIGIN
}

# Directory preparation
pre_process()
{
	# Trace log added @20140409 by H
	echo "----------------------------------------------------------------------"  >>$LOG_POS
	echo "`date +%Y-%m-%d`" >>$LOG_POS

	# Pre-processing
	# mkdir /home/ndvr/public/hanbo/github_origin && cd $_
	if [ -d /home/ndvr/public/source/github_origin ]; then
	        cd $GITHUB_ORIGIN
	else
	        #mkdir /home/ndvr/public/source/github_origin && cd $_
	        mkdir $GITHUB_ORIGIN && cd $GITHUB_ORIGIN
	fi
	[ -d ../`date +%Y-%m-%d`-ph2 ] || mkdir ../`date +%Y-%m-%d`-ph2
	[ -d ../`date +%Y-%m-%d`-ph3 ] || mkdir ../`date +%Y-%m-%d`-ph3
}

# Processing entry
main()
{
	# create directory for storing source
	pre_process

	# get source from github
	src_get_main

	# encode change
	code_change
}

# Entry
main
if [ "$R_RESULT" -ne "$R_SUCCEED" ]; then
	echo "*****Error: Unknown error happened, please check the log file for more information!*****" >>$LOG_POS
elif [ $PH2_SRC_DOWNLOAD_RESULT -eq $R_SUCCEED ] && [ $PH3_SRC_DOWNLOAD_RESULT -ne $R_SUCCEED ]; then
	echo "Ph2 source download succeed, but ph3 source download failed."
	echo "Please check the log file for more infomation."
elif [ $PH2_SRC_DOWNLOAD_RESULT -ne $R_SUCCEED ] && [ $PH3_SRC_DOWNLOAD_RESULT -eq $R_SUCCEED ]; then
	echo "Ph3 source download succeed, but ph2 source download failed."
	echo "Please check the log file for more infomation."
else
        echo "Source download successful."
        echo "Source download successful." >>$LOG_POS
fi

exit 0
