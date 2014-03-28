#!/bin/bash -x

TIME="00:20:00"

while [ `date +%X` != "$TIME" ]
do
    sleep 1
done

func() {
    echo "background function"
}

sleep 10 && func &



echo "equal"

exit 0
