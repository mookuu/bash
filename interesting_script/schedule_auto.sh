#!/bin/bash -x

#
# Schedule file

TIME="01:45:10"
WAIT_TIME=1800
E_TIMEOUT=86
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

[ -d `date +%b` ] || mkdir `date +%b`
cd `date +%b`
# [ ! -f `date +%Y%m%d`.md ]
touch test.md && chmod 644 test.md

# Add common sentences
echo "Schedule for `date +%Y-%m-%d`" >>test.md
echo "=======================" >>test.md
i=1
#while [ $i -le 5 ]
#do
#	echo >>`date +%Y%m%d`.md
#	echo "$i." >>`date +%Y%m%d`.md
#	((++i))
#done

# Catch signal 14
Int14Vector() {
	echo "before git add"
	git add test.md
	echo "before git commit"
	git commit -m "Schedule of `date -d today`"
	echo "before push"
	git push origin master
	echo "Schedule added success"

	exit $TIMER_INTEERRUPT
}

# catch signal
trap Int14Vector $TIMER_INTEERRUPT

# TODO: timer set failed
# sleep 5 && kill -s 14 $! &

exit 0
