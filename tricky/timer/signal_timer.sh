#!/bin/bash -x

TIMER_INTEERRUPT=14
TIME_LIMIT=5

# Catch signal 14
Int14Vector() {
    answer="TIMEOUT"
    PrintAnswer
    exit $TIMER_INTEERRUPT
}

PrintAnswer() {
    if [ x$answer = x"TIMEOUT" ]; then
        echo $answer
    else
        echo Input answer: $answer # TimerOn function no longer needed
        kill $!                 # kill last job running in background
    fi
}


# Set timer
TimerOn() {
    # wait 3 seconds and send signal 14 to current shell
    sleep $TIME_LIMIT && kill -s 14 $$ & # run background
}

trap Int14Vector $TIMER_INTEERRUPT # catch signal


echo -n "Plz input something: "
# Set timer
TimerOn

read answer

PrintAnswer

#  Admittedly, this is a kludgy implementation of timed input.
#  However, the "-t" option to "read" simplifies this task.
#  See the "t-out.sh" script.
#  However, what about timing not just single user input,
#+ but an entire script?

#  If you need something really elegant ...
#+ consider writing the application in C or C++,
#+ using appropriate library functions, such as 'alarm' and 'setitimer.'

exit 0

exit 0
