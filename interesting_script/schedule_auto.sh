#!/bin/bash

#
# Schedule file

TIME="00:00:00"
# MONTHS="Jan. Feb. Apr. May Jun. Jul. Aug. Sep. Oct. Nov. Dec."

# Create file at 00:00:00
# TODO: run in background or schedule
while [ `date +%X` != "$TIME" ]
do
	sleep 1
done
# echo "recall from background"

[ -d `date +%b` ] || mkdir `date +%b`
cd `date +%b`
# [ ! -f `date +%Y%m%d`.md ]
touch `date +%Y%m%d`.md && chmod 644 `date +%Y%m%d`.md

# Add common sentences
echo "Schedule" >>`date +%Y%m%d`.md
echo "========" >>`date +%Y%m%d`.md
i=1
while [ $i -le 5 ]
do
	echo "$i." >>`date +%Y%m%d`.md
	echo >>`date +%Y%m%d`.md
	((++i))
done

# git
git() {
	git add `date +%Y%m%d`.md
	git commit -m "Schedule of `date -d today`"
	git push origin master
	echo "Schedule added success"
}
sleep 30m && git &

exit 0
