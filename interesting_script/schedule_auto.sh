#!/bin/bash -x

#
# Schedule file

TIME="00:00:00"
RET=0
WAIT_TIME=1800
E_TIMEOUT=86
E_PUSHERR=87
TIMER_INTEERRUPT=14
# MONTHS="Jan. Feb. Apr. May Jun. Jul. Aug. Sep. Oct. Nov. Dec."

# Create file at 00:00:00
# TODO: run in background or schedule
cnt=0
while [ `date +%X` != "$TIME" ] && [ "$cnt" -le "$WAIT_TIME" ]
do
	((cnt++))	# quit if not within time range + 30min
	sleep 1
done

# Debug
if [ "$cnt" -gt "$WAIT_TIME" ]; then
	echo "[DBG]: time to quit"
	exit $E_TIMEOUT
fi

# echo "recall from background"

[ -d `date +%b` ] && echo "Directory already exists" || mkdir `date +%b`
cd `date +%b`
# [ ! -f `date +%Y-%m-%d`.md ]
touch `date +%Y-%m-%d`.md && chmod 644 `date +%Y-%m-%d`.md

# Add common sentences
echo "Schedule for `date +%Y-%m-%d`" >>`date +%Y-%m-%d`.md
echo "=======================" >>`date +%Y-%m-%d`.md
i=1
while [ $i -le 5 ]
do
	echo >>`date +%Y-%m-%d`.md
	echo "$i." >>`date +%Y-%m-%d`.md
	((++i))
done

# Catch signal 14
Int14Vector() {
	git add `date +%Y-%m-%d`.md
	git commit -m "Schedule of `date -d today`"
	git push origin master
        # push error
	[ "$RET" -ne "$?" ] && echo "Error: error occured when pushing." \
            && exit $E_PUSHERR
        # push OK
	echo "Schedule added success"
	exit $TIMER_INTEERRUPT
}

# catch signal
trap Int14Vector $TIMER_INTEERRUPT

# TODO: timer set failed
sleep 30m && kill -s 14 $$ &

# M1: run in background(not quit the program)
wait

# M2
# read

exit $RET
