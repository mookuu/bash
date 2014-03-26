#!/bin/bash

#
# The number of seconds the script has been running

TIME_LIMIT=10		# time before exit
INTERVAL=1		# sleep time

echo
echo "Hit Control-C to exit before $TIME_LIMIT seconds elapses."
echo

while [ "$SECONDS" -le $TIME_LIMIT ]
do
	if [ "$SECONDS" -le 1 ]; then
		units=second
	else
		units=seconds
	fi

	echo "This script has been running $SECONDS $units"
	sleep $INTERVAL
done

echo -e "\a"	# Beep

exit 0


