#!/bin/bash
#
# 1: add a schedule
# "crontab -e"
# 0 8 * * * shell_path
# 2: restart the cron service
# sudo service cron restart
# or
# sudo /etc/init.d/cron resart
#

# github_src_v2
# update:
#	 trace log added
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
GIT_REMOTE_BRANCH=origin
LOG_POS=/home/ndvr/public/source/log/trace.log	# trace log

# Source directory
D_CNT=3
D_MAC[0]=/CAM/apl
D_MAC[1]=/DVR/apl
D_MAC[2]=/HUB/apl


# Src get
src_get()
{
	[ -d .git ] || git init
	[ $GIT_REMOTE_BRANCH = `git remote` ] || \
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
		mv * ../`date +%Y-%m-%d`-$1
		echo "Download succeed."
		R_RESULT=$R_SUCCEED
	else
		# echo "Error: cann't download $1 source." >>$LOG_POS
		R_RESULT=$R_FAILED

		# Retry: 3 times
		while [ $RETRY_CNT -lt $RETRY_MAX ] && [ $R_RESULT != $R_SUCCEED ]
		do
			((RETRY_CNT++))
			echo "Download failed! Will retry in 10 minutes." >>$LOG_POS
			echo "errno: [$E_NETUNREACH]" >>$LOG_POS
			sleep $TIMELIMIT && echo "Retry[$RETRY_CNT]" >>$LOG_POS && src_get $1
			# end loop???
		done
	fi
}

# Trace log added @20140409 by H
echo "-----------------------------" >>$LOG_POS
echo "`date +%Y-%m-%d`" >>$LOG_POS

# Pre-processing
# mkdir /home/ndvr/public/hanbo/github_origin && cd $_
if [ -d /home/ndvr/public/source/github_origin ]; then
	cd /home/ndvr/public/source/github_origin
else
	mkdir /home/ndvr/public/source/github_origin && cd $_
fi
[ -d ../`date +%Y-%m-%d`-ph2 ] || mkdir ../`date +%Y-%m-%d`-ph2
[ -d ../`date +%Y-%m-%d`-ph3 ] || mkdir ../`date +%Y-%m-%d`-ph3

# Get src from github
# Ph2
src_get ph2
if [ $R_RESULT -ne $R_SUCCEED ]; then
        echo "*****Error: cann't download ph2 source, please check the network!*****" >>$LOG_POS
#       exit $NET_UNREACH
fi
RETRY_CNT=0
# Ph3
src_get ph3
if [ $R_RESULT -ne $R_SUCCEED ]; then
	echo "*****Error: cann't download ph3 source, please check the network!*****" >>$LOG_POS
	exit $NET_UNREACH
fi
# TODO: ph3_sb

# Clear
cd .. && rm -fr /home/ndvr/public/source/github_origin

# Encode change
for val in ${D_MAC[@]}
do
	cd `date +%Y-%m-%d`-ph2$val && `./NKF.sh euc-jp` && cd -
	cd `date +%Y-%m-%d`-ph3$val && `./NKF.sh euc-jp`
	[ $? -ne $RET ] && echo "Error: error occured when change encode." >>$LOG_POS && echo "$?"
done

echo "Source download successful."

exit 0
