#!/bin/bash -x

<<<<<<< HEAD
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
=======
NUMBER=10

for i in $(seq $NUMBER)
do
    echo $i
done
>>>>>>> 76528c425009ed147bf987e4109700c81acb9850
